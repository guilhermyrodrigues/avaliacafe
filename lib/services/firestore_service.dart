import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cafe_model.dart';
import '../models/review_model.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Referência às coleções
  static final CollectionReference _cafesCollection =
      _firestore.collection('cafes');
  static final CollectionReference _reviewsCollection =
      _firestore.collection('reviews');

  // Adicionar cafeteria
  static Future<void> addCafe(String name, String address) async {
    try {
      await _cafesCollection.add({
        'name': name,
        'address': address,
      });
    } catch (e) {
      print('Erro ao adicionar cafeteria: $e');
    }
  }

  // Atualizar cafeteria
  static Future<void> updateCafe(String cafeId, String name, String address) async {
    try {
      await _cafesCollection.doc(cafeId).update({
        'name': name,
        'address': address,
      });
    } catch (e) {
      print('Erro ao atualizar cafeteria: $e');
    }
  }

  // Deletar cafeteria
  static Future<void> deleteCafe(String cafeId) async {
    try {
      await _cafesCollection.doc(cafeId).delete();
    } catch (e) {
      print('Erro ao deletar cafeteria: $e');
    }
  }

  // Obter lista de cafeterias
  static Stream<List<CafeModel>> getCafes() {
    return _cafesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CafeModel(
          id: doc.id,
          name: doc['name'],
          address: doc['address'],
        );
      }).toList();
    });
  }

  // Adicionar avaliação
  static Future<void> addReview(String cafeId, double rating, String comment) async {
    await FirebaseFirestore.instance.collection('reviews').add({
      'cafeId': cafeId,
      'rating': rating,
      'comment': comment,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Obtém as avaliações de uma cafeteria específica
  static Stream<List<Map<String, dynamic>>> getReviewsForCafe(String cafeId) {
    return FirebaseFirestore.instance
        .collection('reviews')  // Agora estamos buscando na coleção reviews
        .where('cafeId', isEqualTo: cafeId)  // Filtra pelas avaliações do cafeId
        .orderBy('createdAt', descending: true)  // Ordena as avaliações pela data
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}

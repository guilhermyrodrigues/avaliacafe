import 'package:flutter/material.dart';
import '../models/cafe_model.dart';
import '../models/review_model.dart'; // Importa o ReviewModel
import '../widgets/review_card.dart'; // Um card para mostrar a avaliação
import '../services/firestore_service.dart';
import 'add_review_screen.dart'; // Tela de adicionar avaliação

class CafeDetailScreen extends StatelessWidget {
  final CafeModel cafe;

  const CafeDetailScreen({Key? key, required this.cafe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cafe.name)),
      body: Column(
        children: [
          ListTile(
            title: Text(cafe.name),
            subtitle: Text(cafe.address),
          ),
          const Divider(),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: FirestoreService.getReviewsForCafe(cafe.id), // Certifique-se que está retornando uma lista de Map<String, dynamic>
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar avaliações: ${snapshot.error}'));
                }

                final reviews = snapshot.data ?? [];

                if (reviews.isEmpty) {
                  return const Center(child: Text('Nenhuma avaliação encontrada.'));
                }

                // Converte o Map<String, dynamic> em ReviewModel
                final reviewModels = reviews.map((reviewMap) {
                  final id = reviewMap['id'] ?? ''; // Aqui assumimos que o ID está no map
                  return ReviewModel.fromMap(id, reviewMap); // Converte para ReviewModel
                }).toList();

                return ListView(
                  children: reviewModels.map((review) {
                    return ReviewCard(review: review);  // Exibe a avaliação em um card
                  }).toList(),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Vai para a tela de adicionar avaliação
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddReviewScreen(cafe: cafe),
                ),
              );
            },
            child: const Text('Adicionar Avaliação'),
          ),
        ],
      ),
    );
  }
}

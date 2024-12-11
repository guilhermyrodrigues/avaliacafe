import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_cafe_screen.dart';
import 'cafe_datail_screen.dart'; // Nova tela de detalhes da cafeteria
import '../models/cafe_model.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para validar URL
  bool isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && uri.isAbsolute;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cafeterias'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('cafes').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final cafeterias = snapshot.data!.docs;

          if (cafeterias.isEmpty) {
            return const Center(
              child: Text('Nenhuma cafeteria cadastrada.'),
            );
          }

          return ListView.builder(
            itemCount: cafeterias.length,
            itemBuilder: (context, index) {
              var data = cafeterias[index].data() as Map<String, dynamic>;
              var id = cafeterias[index].id;

              // Recuperando a URL da imagem
              var imageUrl = data['imageUrl'] ?? '';
              if (imageUrl.isEmpty || !isValidUrl(imageUrl)) {
                imageUrl = 'https://via.placeholder.com/150'; // URL de placeholder
              }

              var cafe = CafeModel(
                id: id,
                name: data['name'] ?? 'Sem Nome',
                address: data['address'] ?? 'Sem Endereço',
                imageUrl: imageUrl,
              );

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      cafe.imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const SizedBox(
                          width: 50,
                          height: 50,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported, size: 50);
                      },
                    ),
                  ),
                  title: Text(cafe.name),
                  subtitle: Text(cafe.address),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // Abre a tela de edição com os dados da cafeteria
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddCafeScreen(cafe: cafe),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          // Remove a cafeteria do Firestore
                          await _firestore.collection('cafes').doc(id).delete();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Cafeteria deletada com sucesso!')),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.star, color: Colors.amber),
                        onPressed: () {
                          // Redireciona para a tela de detalhes da cafeteria, onde pode avaliar
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CafeDetailScreen(cafe: cafe),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Abre a tela de adicionar nova cafeteria
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCafeScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

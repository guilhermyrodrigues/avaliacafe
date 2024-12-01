import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/cafe_model.dart';

class AddReviewScreen extends StatelessWidget {
  final CafeModel cafe;

  AddReviewScreen({Key? key, required this.cafe}) : super(key: key);

  final TextEditingController commentController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Avaliação')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: ratingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Nota (0 a 5)'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: commentController,
              decoration: const InputDecoration(labelText: 'Comentário'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                FirestoreService.addReview(
                  cafe.id,
                  double.parse(ratingController.text),
                  commentController.text,
                );

                // Exibe uma mensagem de sucesso
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Avaliação adicionada com sucesso!')),
                );

                // Volta para a tela anterior
                Navigator.pop(context);
              },
              child: const Text('Salvar Avaliação'),
            ),
          ],
        ),
      ),
    );
  }
}

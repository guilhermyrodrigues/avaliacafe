import 'package:flutter/material.dart';
import '../models/cafe_model.dart';
import '../services/firestore_service.dart';

class AddCafeScreen extends StatelessWidget {
  final CafeModel? cafe;

  AddCafeScreen({Key? key, this.cafe}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Preenche os campos se um café estiver sendo editado
    if (cafe != null) {
      nameController.text = cafe!.name;
      addressController.text = cafe!.address;
      imageController.text = cafe!.imageUrl;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(cafe == null ? 'Adicionar Cafeteria' : 'Editar Cafeteria'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Endereço'),
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(labelText: 'URL da Imagem'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty ||
                    addressController.text.isEmpty ||
                    imageController.text.isEmpty) {
                  // Validação básica
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Preencha todos os campos, incluindo a URL da imagem!'),
                    ),
                  );
                  return;
                }

                if (cafe == null) {
                  // Adiciona nova cafeteria
                  await FirestoreService.addCafe(
                    nameController.text,
                    addressController.text,
                    imageController.text,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cafeteria adicionada com sucesso!'),
                    ),
                  );
                } else {
                  // Atualiza uma cafeteria existente
                  await FirestoreService.updateCafe(
                    cafe!.id,
                    nameController.text,
                    addressController.text,
                    imageController.text,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cafeteria atualizada com sucesso!'),
                    ),
                  );
                }

                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}

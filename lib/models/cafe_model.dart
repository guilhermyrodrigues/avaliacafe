class CafeModel {
  final String id;
  final String name;
  final String address;
  final String imageUrl; // Adicionado para armazenar a URL da imagem

  CafeModel({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl // Campo opcional
  });

  // Converter dados do Firebase para CafeModel
  factory CafeModel.fromMap(String id, Map<String, dynamic> data) {
    return CafeModel(
      id: id,
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      imageUrl: data['imageUrl'], // Adicionado
    );
  }

  // Converter CafeModel para Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'imageUrl': imageUrl, // Adicionado
    };
  }
}

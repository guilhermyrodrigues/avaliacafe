class UserModel {
  final String id;
  final String email;
  final bool isAdmin;

  UserModel({
    required this.id,
    required this.email,
    required this.isAdmin,
  });

  // Converter dados do Firebase para UserModel
  factory UserModel.fromMap(String id, Map<String, dynamic> data) {
    return UserModel(
      id: id,
      email: data['email'] ?? '',
      isAdmin: data['isAdmin'] ?? false,
    );
  }

  // Converter UserModel para Map
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'isAdmin': isAdmin,
    };
  }
}

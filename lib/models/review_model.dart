class ReviewModel {
  final String id;
  final String cafeId;
  final double rating;
  final String comment;
  final String userName; // Agora não permite nulo
  final DateTime? createdAt;

  ReviewModel({
    required this.id,
    required this.cafeId,
    required this.rating,
    required this.comment,
    required this.userName, // Campo obrigatório
    this.createdAt,
  });

  factory ReviewModel.fromMap(String id, Map<String, dynamic> data) {
    return ReviewModel(
      id: id,
      cafeId: data['cafeId'] ?? '',
      rating: (data['rating'] ?? 0).toDouble(),
      comment: data['comment'] ?? '',
      userName: data['userName'] ?? 'Anonymous', // Define um valor padrão
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'].toDate().toString())
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cafeId': cafeId,
      'rating': rating,
      'comment': comment,
      'userName': userName, // Sem nulo
      'createdAt': createdAt,
    };
  }
}

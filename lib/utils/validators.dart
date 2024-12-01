// Valida se o e-mail fornecido é válido.
String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'O e-mail é obrigatório';
  }
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  if (!emailRegex.hasMatch(email)) {
    return 'Por favor, insira um e-mail válido';
  }
  return null;
}

// Valida se a senha é válida (mínimo de 6 caracteres).
String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return 'A senha é obrigatória';
  }
  if (password.length < 6) {
    return 'A senha deve ter pelo menos 6 caracteres';
  }
  return null;
}

// Valida se o nome fornecido é válido.
String? validateName(String? name) {
  if (name == null || name.isEmpty) {
    return 'O nome é obrigatório';
  }
  if (name.length < 3) {
    return 'O nome deve ter pelo menos 3 caracteres';
  }
  return null;
}

// Valida se o comentário não está vazio.
String? validateComment(String? comment) {
  if (comment == null || comment.isEmpty) {
    return 'O comentário não pode ser vazio';
  }
  if (comment.length > 500) {
    return 'O comentário não pode ter mais de 500 caracteres';
  }
  return null;
}

// Valida se a avaliação está dentro do intervalo permitido (0 a 5).
String? validateRating(double? rating) {
  if (rating == null || rating < 0 || rating > 5) {
    return 'A avaliação deve ser entre 0 e 5';
  }
  return null;
}

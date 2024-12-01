import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login com email e senha
  static Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Erro no login: $e');
      return null;
    }
  }

  // Registro com email e senha
  static Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Erro no registro: $e');
      return null;
    }
  }

  // Logout
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  // Recupera o usuário atual
  static User? get currentUser => _auth.currentUser;

  // Verifica se o usuário é admin
  static Future<bool> isAdmin() async {
    if (currentUser == null) return false;

    // Exemplo: Suponha que o campo 'isAdmin' seja usado no Firestore para identificar admins
    // É necessário ajustar para refletir como você define administradores no Firestore
    final adminEmails = ['admin@example.com']; // Lista de emails admin
    return adminEmails.contains(currentUser!.email);
  }

  static Stream<User?> get authStateChanges => _auth.authStateChanges();
}

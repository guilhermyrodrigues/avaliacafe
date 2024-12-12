import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white), // White text for app bar
        ),
        backgroundColor: Colors.brown, // Brown app bar background
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Custom email field with icon and brown border
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email, color: Colors.brown),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown, width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Custom password field with icon and brown border
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                prefixIcon: const Icon(Icons.lock, color: Colors.brown),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown, width: 2.0),
                ),
              ),
              obscureText: true, // Aqui você define o texto como oculto
            ),
            const SizedBox(height: 16),
            // Custom elevated button with rounded corners and brown color
            ElevatedButton(
              onPressed: () async {
                await AuthService.signIn(
                  emailController.text,
                  passwordController.text,
                );
              },
              child: const Text('Entrar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 221, 184, 171), // Set button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

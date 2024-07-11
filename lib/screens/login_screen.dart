import 'package:flutter/material.dart';
import './homepage.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: const Text('Login',
                style: TextStyle(color: Colors.white, fontSize: 32.0)
            ),
            backgroundColor: Colors.blue[900],
            centerTitle: true
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
                'Realize seu Login para continuar',
                style: TextStyle(fontSize: 30.0),
                textAlign: TextAlign.center
            ),
            const SizedBox(height: 80.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'CPF',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40.0),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
                onPressed: () {
                  // Navega para a HomePage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                    textStyle: const TextStyle(fontSize: 24.0,)
                ),
                child: const Text(
                    'Entrar',
                    style: TextStyle(color: Colors.white)
                )
            )
          ],
        ),
      ),
    );
  }
}
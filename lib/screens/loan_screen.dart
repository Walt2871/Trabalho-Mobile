import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'homepage.dart'; // Importe esta biblioteca para trabalhar com datas

class LoanPage extends StatelessWidget {
  const LoanPage({Key? key});

  @override
  Widget build(BuildContext context) {
    // Obtenha a data atual
    final currentDate = DateTime.now();

    // Calcule a data limite (7 dias adiante)
    final nextWeekDate = currentDate.add(const Duration(days: 7));

    // Formate as datas para exibição
    final formattedCurrentDate = DateFormat('dd/MM/yyyy').format(currentDate);
    final formattedNextWeekDate = DateFormat('dd/MM/yyyy').format(nextWeekDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastrar Empréstimo',
          style: TextStyle(color: Colors.white, fontSize: 24.0),
        ),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'CPF'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Livro'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Data de retirada'),
              initialValue: formattedCurrentDate, // Defina a data atual como valor inicial
              enabled: false, // Impede que o campo seja editado
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Data limite'),
              initialValue: formattedNextWeekDate, // Defina a data de 7 dias adiante como valor inicial
              enabled: false, // Impede que o campo seja editado
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implemente a lógica para o botão "Cadastrar" aqui
              },
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Lógica do botão de QR
        },
        backgroundColor: Colors.blue[900],
        child: const Icon(Icons.qr_code),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: 'Acervo'),
          BottomNavigationBarItem(icon: Icon(Icons.app_registration), label: 'Empréstimo'),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.blue[800],
        onTap: (int index) {
          if (index == 0) {
            // Navegar para a HomePage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
        },
      ),
    );
  }
}


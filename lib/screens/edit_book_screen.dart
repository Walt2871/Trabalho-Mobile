import 'package:flutter/material.dart';

class EditBookPage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String publisher;

  const EditBookPage({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.publisher,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController(text: title);
    final TextEditingController authorController = TextEditingController(text: author);
    final TextEditingController publisherController = TextEditingController(text: publisher);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Livro'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              imageUrl,
              height: 200,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: authorController,
              decoration: const InputDecoration(
                labelText: 'Autor',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: publisherController,
              decoration: const InputDecoration(
                labelText: 'Editora',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Adicione a lógica para cancelar a edição
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Adicione a lógica para confirmar a edição
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Confirmar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../database/bookDAO.dart';

class EditBookPage extends StatefulWidget {
  final int id;
  final String imageUrl;
  final String title;
  final String author;
  final String publisher;
  final Future<void> Function()? onUpdate;  // Adiciona o callback

  const EditBookPage({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.publisher,
    this.onUpdate,
  });

  @override
  _EditBookPageState createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final BookDao _bookDao = BookDao();
  late TextEditingController titleController;
  late TextEditingController authorController;
  late TextEditingController publisherController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    authorController = TextEditingController(text: widget.author);
    publisherController = TextEditingController(text: widget.publisher);
  }

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    publisherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAsset = widget.imageUrl.startsWith('assets/');
    final isLocalFile = widget.imageUrl.startsWith('file://');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Livro'),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (widget.imageUrl.startsWith('assets/'))
                Image.asset(
                  widget.imageUrl,
                  height: 200,
                )
              else if (widget.imageUrl.startsWith('/data'))
                Image.file(
                  File(widget.imageUrl),
                  height: 200,
                )
              else
                const Icon(
                  Icons.image_not_supported,
                  size: 200,
                  color: Colors.grey,
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
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final updatedBook = Book(
                        id: widget.id,
                        imageUrl: widget.imageUrl, // Manter a URL da imagem original se não for alterada
                        title: titleController.text,
                        publisher: publisherController.text,
                        author: authorController.text,
                      );

                      await _updateBook(updatedBook);

                      if (widget.onUpdate != null) {
                        await widget.onUpdate!();  // Notifica sobre a atualização
                      }

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
      ),
    );
  }

  Future<void> _updateBook(Book updatedBook) async {
    await _bookDao.updateBook(updatedBook);
  }
}

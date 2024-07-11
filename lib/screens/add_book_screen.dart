import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/book.dart';

class AddBookPage extends StatefulWidget {
  final Function(Book) onAddBook;

  const AddBookPage({super.key, required this.onAddBook});

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  final _titleController = TextEditingController();
  final _publisherController = TextEditingController();
  final _authorController = TextEditingController();

  Future<void> _pickImage() async {
    final XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        _image = selectedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Livro',
          style: TextStyle(color: Colors.white, fontSize: 32.0),
        ),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_image != null)
                Image.file(File(_image!.path)),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Escolher Imagem'),
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o título do livro';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _publisherController,
                decoration: const InputDecoration(labelText: 'Editora'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a editora do livro';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: 'Autor'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o autor do livro';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final newBook = Book(
                      imageUrl: _image != null ? _image!.path : '',
                      title: _titleController.text,
                      publisher: _publisherController.text,
                      author: _authorController.text,
                    );
                    widget.onAddBook(newBook);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Adicionar Livro'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers and image file if needed
    _titleController.dispose();
    _publisherController.dispose();
    _authorController.dispose();
    super.dispose();
  }
}


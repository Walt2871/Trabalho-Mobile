import 'dart:io';

import 'package:flutter/material.dart';
import '../database/bookDAO.dart';
import '../models/book.dart';
import 'add_book_screen.dart';
import 'edit_book_screen.dart';
import 'loan_screen.dart';
import 'package:diacritic/diacritic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BookDao _bookDao = BookDao();
  List<Book> _books = [];
  List<Book> _filteredBooks = [];
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchBooks();
    _searchController.addListener(_filterBooks);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterBooks);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchBooks() async {
    _books = await _bookDao.getBooks();
    setState(() {
      _filteredBooks = _books;
    });
  }

  void _filterBooks() {
    setState(() {
      final query = removeDiacritics(_searchController.text.toLowerCase());
      _filteredBooks = _books
          .where((book) => removeDiacritics(book.title.toLowerCase()).contains(query))
          .toList();
    });
  }

  void _addBook(Book book) async {
    await _bookDao.insertBook(book);
    _fetchBooks();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else if (index == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoanPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Acervo de Livros',
          style: TextStyle(color: Colors.white, fontSize: 32.0),
        ),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar',
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search, color: Colors.blue[900]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredBooks.length,
              itemBuilder: (context, index) {
                final book = _filteredBooks[index];
                return _buildBookItem(
                  context,
                  book.id,
                  book.imageUrl,
                  book.title,
                  book.publisher,
                  book.author,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBookPage(onAddBook: _addBook),
            ),
          );
        },
        backgroundColor: Colors.blue[900],
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Acervo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Empréstimo',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildBookItem(
      BuildContext context,
      int id,
      String imageUrl,
      String title,
      String publisher,
      String author,
      ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Verifica se a URL da imagem é local ou de ativo
            imageUrl.startsWith('assets/')
                ? Image.asset(
              imageUrl,
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            )
                : imageUrl.startsWith('/data')
                ? Image.file(
              File(imageUrl),
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            )
                : Container(
              width: 100,
              height: 150,
              color: Colors.grey[300], // Placeholder se o URL for inválido
              child: const Center(
                child: Text(
                  'Imagem não disponível',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    publisher,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    author,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                _navigateToEditPage(id, imageUrl, title, author, publisher);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToEditPage(int id, String imageUrl, String title, String author, String publisher) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBookPage(
          id: id,
          imageUrl: imageUrl,
          title: title,
          author: author,
          publisher: publisher,
          onUpdate: _fetchBooks,  // Passa a função para atualizar a lista de livros
        ),
      ),
    );


    if (result == true) {
      _fetchBooks();  // Atualiza a lista de livros
    }
  }
}

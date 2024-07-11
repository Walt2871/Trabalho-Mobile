import 'package:flutter/material.dart';
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
  final List<Book> _books = [
    Book(
      imageUrl: 'https://via.placeholder.com/100',
      title: 'Título do Livro 1',
      publisher: 'Editora 1',
      author: 'Autor 1',
    ),
    Book(
      imageUrl: 'https://via.placeholder.com/100',
      title: 'Título do Livro 2',
      publisher: 'Editora 2',
      author: 'Autor 2',
    ),
    Book(
      imageUrl: 'https://via.placeholder.com/100',
      title: 'Título do Livro 3',
      publisher: 'Editora 3',
      author: 'Autor 3',
    ),
  ];

  List<Book> _filteredBooks = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredBooks = _books;
    _searchController.addListener(_filterBooks);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterBooks);
    _searchController.dispose();
    super.dispose();
  }

  void _filterBooks() {
    setState(() {
      final query = removeDiacritics(_searchController.text.toLowerCase());
      _filteredBooks = _books
          .where((book) => removeDiacritics(book.title.toLowerCase()).contains(query))
          .toList();
    });
  }

  void _addBook(Book book) {
    setState(() {
      _books.add(book);
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return; // Evitar recarregar a página atual

    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        // Navegar para a HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else if (index == 1) {
        // Navegar para a SecondPage
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
        title: const Text('Acervo de Livros',
            style: TextStyle(color: Colors.white, fontSize: 32.0)
        ),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // Navegar para a página de adição de livro
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
            Image.network(
              imageUrl,
              width: 100,
              height: 150,
              fit: BoxFit.cover,
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
                // Navegação para a página de edição
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditBookPage(
                      imageUrl: imageUrl,
                      title: title,
                      author: author,
                      publisher: publisher,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

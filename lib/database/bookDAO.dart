import 'package:sqflite/sqflite.dart';
import '../models/book.dart';
import 'open_database.dart';

class BookDao {
  Future<Database> get _db async {
    return await DatabaseHelper().database;
  }

  Future<int> insertBook(Book book) async {
    final db = await _db;
    return await db.insert('books', book.toMap());
  }

  Future<void> insertInitialBooks() async {
    final initialBooks = [
      Book(
        'https://via.placeholder.com/100',
        'Título do Livro 1',
        'Editora 1',
        'Autor 1',
      ),
      Book(
        'https://via.placeholder.com/100',
        'Título do Livro 2',
        'Editora 2',
        'Autor 2',
      ),
      Book(
        'https://via.placeholder.com/100',
        'Título do Livro 3',
        'Editora 3',
        'Autor 3',
      ),
    ];

    final db = await _db;

    // Verifique se a tabela está vazia antes de inserir livros iniciais
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM books'));
    if (count == 0) {
      for (var book in initialBooks) {
        await insertBook(book);
      }
    }
  }

  Future<int> updateBook(Book book) async {
    final db = await _db;
    return await db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<int> deleteBook(int id) async {
    final db = await _db;
    return await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Book>> getBooks() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query('books');

    return List.generate(maps.length, (i) {
      return Book.fromMap(maps[i]);
    });
  }
}

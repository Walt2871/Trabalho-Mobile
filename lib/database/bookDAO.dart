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

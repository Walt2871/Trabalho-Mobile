import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'books.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    debugPrint("criou o database");
    await db.execute('''
    CREATE TABLE books(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      imageUrl TEXT,
      title TEXT,
      publisher TEXT,
      author TEXT
    )
    ''');

    // Adicione aqui a inserção inicial de livros após a criação da tabela
    await insertInitialBooks(db);
  }

  Future<void> insertInitialBooks(Database db) async {
    // Insira os livros iniciais aqui
    await db.insert('books', {
      'imageUrl': 'assets/images/livro1.jpg',
      'title': 'Grandes Contos',
      'publisher': 'Martin Claret',
      'author': 'H.P. Lovecraft',
    });

    await db.insert('books', {
      'imageUrl': 'assets/images/livro2.jpg',
      'title': 'Medo Clássico',
      'publisher': 'Darkside',
      'author': 'H.P. Lovecraft',
    });

    await db.insert('books', {
      'imageUrl': 'assets/images/livro3.jpg',
      'title': 'Nas Montanhas da Loucura',
      'publisher': 'Principis',
      'author': 'H.P. Lovecraft',
    });
  }
}

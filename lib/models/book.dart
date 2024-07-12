class Book {
  final int id;
  final String imageUrl;
  final String title;
  final String publisher;
  final String author;

  Book({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.publisher,
    required this.author,
  });

  Book copyWith({
    int? id,
    String? imageUrl,
    String? title,
    String? publisher,
    String? author,
  }) {
    return Book(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      publisher: publisher ?? this.publisher,
      author: author ?? this.author,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'publisher': publisher,
      'author': author,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      imageUrl: map['imageUrl'],
      title: map['title'],
      publisher: map['publisher'],
      author: map['author'],
    );
  }
}

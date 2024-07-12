class Book {
  final int? id;
  final String _imageUrl;
  final String _title;
  final String _publisher;
  final String _author;

  Book(this._imageUrl, this._title, this._publisher, this._author, {this.id});

  String get imageUrl => _imageUrl;
  String get title => _title;
  String get publisher => _publisher;
  String get author => _author;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': _imageUrl,
      'title': _title,
      'publisher': _publisher,
      'author': _author,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      map['imageUrl'],
      map['title'],
      map['publisher'],
      map['author'],
      id: map['id'],
    );
  }
}


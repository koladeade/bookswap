class Book {
  String id;
  String title;
  String author;
  String condition; // New, Like New, Good, Used
  String imageUrl;
  String ownerId; // UID of user

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.condition,
    required this.imageUrl,
    required this.ownerId,
  });

  factory Book.fromMap(Map<String, dynamic> data, String docId) => Book(
    id: docId,
    title: data['title'],
    author: data['author'],
    condition: data['condition'],
    imageUrl: data['imageUrl'],
    ownerId: data['ownerId'],
  );

  Map<String, dynamic> toMap() => {
    'title': title,
    'author': author,
    'condition': condition,
    'imageUrl': imageUrl,
    'ownerId': ownerId,
  };
}

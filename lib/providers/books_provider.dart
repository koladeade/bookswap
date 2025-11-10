import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class BooksProvider with ChangeNotifier {
  List<Book> _books = [];
  bool isLoading = false;

  List<Book> get books => _books;

  Future<void> fetchBooks() async {
    isLoading = true;
    notifyListeners();
    final snapshot = await FirebaseFirestore.instance.collection('books').get();
    _books = snapshot.docs
        .map((doc) => Book.fromMap(doc.data(), doc.id))
        .toList();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addBook(Book book) async {
    final doc = await FirebaseFirestore.instance
        .collection('books')
        .add(book.toMap());
    book.id = doc.id;
    _books.add(book);
    notifyListeners();
  }

  Future<void> updateBook(Book book) async {
    await FirebaseFirestore.instance
        .collection('books')
        .doc(book.id)
        .update(book.toMap());
    final index = _books.indexWhere((b) => b.id == book.id);
    if (index != -1) _books[index] = book;
    notifyListeners();
  }

  Future<void> deleteBook(String id) async {
    await FirebaseFirestore.instance.collection('books').doc(id).delete();
    _books.removeWhere((b) => b.id == id);
    notifyListeners();
  }
}

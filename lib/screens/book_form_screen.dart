import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/books_provider.dart';
import '../providers/auth_provider.dart';
import '../models/book.dart';

@immutable
class BookFormScreen extends StatefulWidget {
  final Book? editBook;
  const BookFormScreen({super.key, this.editBook});

  @override
  State<BookFormScreen> createState() => _BookFormScreenState();
}

class _BookFormScreenState extends State<BookFormScreen> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  String condition = "New";
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    if (widget.editBook != null) {
      titleController.text = widget.editBook!.title;
      authorController.text = widget.editBook!.author;
      condition = widget.editBook!.condition;
      imageUrl = widget.editBook!.imageUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    final booksProvider = Provider.of<BooksProvider>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editBook == null ? 'Post a Book' : 'Edit Book'),
      ),
      backgroundColor: Color(0xFF121329),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Book Title',
                filled: true,
                fillColor: Color(0xFF191A32),
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 12),
            TextField(
              controller: authorController,
              decoration: InputDecoration(
                labelText: 'Author',
                filled: true,
                fillColor: Color(0xFF191A32),
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: condition,
              items: [
                'New',
                'Like New',
                'Good',
                'Used',
              ].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) => setState(() => condition = val!),
              decoration: InputDecoration(
                labelText: 'Condition',
                filled: true,
                fillColor: Color(0xFF191A32),
                labelStyle: TextStyle(color: Colors.white),
              ),
              dropdownColor: Color(0xFF191A32),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Image URL (optional)',
                filled: true,
                fillColor: Color(0xFF191A32),
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
              onChanged: (val) => imageUrl = val,
            ),
            SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFFFFD600)),
                  foregroundColor: WidgetStatePropertyAll(Colors.black),
                ),
                child: Text(widget.editBook == null ? 'Post' : 'Save Changes'),
                onPressed: () async {
                  if (titleController.text.isEmpty ||
                      authorController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Title and Author required')),
                    );
                    return;
                  }
                  if (widget.editBook == null) {
                    final book = Book(
                      id: '',
                      title: titleController.text,
                      author: authorController.text,
                      condition: condition,
                      imageUrl: imageUrl,
                      ownerId: auth.user!.uid,
                    );
                    await booksProvider.addBook(book);
                  } else {
                    final edited = Book(
                      id: widget.editBook!.id,
                      title: titleController.text,
                      author: authorController.text,
                      condition: condition,
                      imageUrl: imageUrl,
                      ownerId: auth.user!.uid,
                    );
                    await booksProvider.updateBook(edited);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

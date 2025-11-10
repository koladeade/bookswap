import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/books_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/swap_provider.dart';
import '../models/book.dart';
import '../models/swap.dart';

class BrowseScreen extends StatefulWidget {
  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<BooksProvider>(context, listen: false).fetchBooks();
  }

  Widget _conditionChip(String label) {
    Color bg;
    switch (label) {
      case "New":
        bg = Color(0xFFFFD600);
        break;
      case "Like New":
        bg = Colors.lightBlue;
        break;
      case "Good":
        bg = Colors.lightGreen;
        break;
      case "Used":
        bg = Colors.grey;
        break;
      default:
        bg = Colors.white;
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final booksProvider = Provider.of<BooksProvider>(context);
    final swapProvider = Provider.of<SwapProvider>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final books = booksProvider.books;

    return ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: books.length,
      itemBuilder: (context, idx) {
        final book = books[idx];
        final isMine = book.ownerId == auth.user?.uid;

        return Card(
          color: Color(0xFF191A32),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
          elevation: 1,
          child: ListTile(
            contentPadding: EdgeInsets.all(12),
            leading: book.imageUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      book.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(width: 50, height: 50, color: Colors.grey),
                    ),
                  )
                : Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.menu_book, color: Colors.white54),
                  ),
            title: Text(
              book.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book.author, style: TextStyle(color: Colors.white70)),
                SizedBox(height: 3),
                Row(
                  children: [
                    _conditionChip(book.condition),
                    if (isMine)
                      Container(
                        margin: EdgeInsets.only(left: 6),
                        child: Text(
                          'Your book',
                          style: TextStyle(color: Colors.green, fontSize: 13),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            trailing: isMine
                ? null
                : ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xFFFFD600),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () async {
                      // Prevent requesting swap on your own book!
                      if (book.ownerId == auth.user?.uid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Cannot swap your own book!')),
                        );
                        return;
                      }
                      await swapProvider.requestSwap(
                        Swap(
                          id: '',
                          bookId: book.id,
                          senderId: auth.user!.uid,
                          recipientId: book.ownerId,
                          status: 'Pending',
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Swap requested!')),
                      );
                    },
                    child: Text('Swap'),
                  ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/books_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/swap_provider.dart';
import 'book_form_screen.dart';
import 'chat_screen.dart';

class MyListingsScreen extends StatefulWidget {
  const MyListingsScreen({super.key});
  @override
  State<MyListingsScreen> createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends State<MyListingsScreen> {
  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthProvider>(context, listen: false);
    Provider.of<BooksProvider>(context, listen: false).fetchBooks();
    Provider.of<SwapProvider>(
      context,
      listen: false,
    ).fetchSwapsForUser(auth.user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final booksProvider = Provider.of<BooksProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    final swapProvider = Provider.of<SwapProvider>(context);

    final myBooks = booksProvider.books
        .where((book) => book.ownerId == auth.user?.uid)
        .toList();
    final sentSwaps = swapProvider.swapsSentByMe;
    final receivedSwaps = swapProvider.swapsForMyBooks;

    return ListView(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xFFFFD600)),
              foregroundColor: WidgetStatePropertyAll(Colors.black),
            ),
            icon: Icon(Icons.add),
            label: Text('Post a Book'),
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => BookFormScreen())),
          ),
        ),

        SizedBox(height: 20),
        Text(
          "My Listings",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...myBooks.isEmpty
            ? [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'No listings yet.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ]
            : myBooks
                  .map(
                    (book) => Card(
                      color: Color(0xFF191A32),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: book.imageUrl.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  book.imageUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.menu_book,
                                  color: Colors.white54,
                                ),
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
                            Text(
                              book.author,
                              style: TextStyle(color: Colors.white70),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3),
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFD600),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                book.condition,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.yellow.shade700,
                              ),
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      BookFormScreen(editBook: book),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () async {
                                await booksProvider.deleteBook(book.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),

        SizedBox(height: 20),
        Text(
          "My Offers Sent",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...sentSwaps.isEmpty
            ? [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'No swap offers sent.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ]
            : sentSwaps
                  .map(
                    (swap) => Card(
                      color: Color(0xFF23244c),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Icon(
                          Icons.swap_horiz,
                          color: Colors.yellow.shade700,
                        ),
                        title: Text(
                          'Book ID: ${swap.bookId}',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Status: ${swap.status}',
                          style: TextStyle(color: Colors.white70),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.chat, color: Colors.blueAccent),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ChatScreen(chatId: swap.id),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () => swapProvider.deleteSwap(swap.id),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),

        SizedBox(height: 20),
        Text(
          "Swap Offers for My Books",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...receivedSwaps.isEmpty
            ? [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'No swap offers received.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ]
            : receivedSwaps
                  .map(
                    (swap) => Card(
                      color: Color(0xFF23244c),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Icon(
                          Icons.swap_horiz,
                          color: Colors.yellow.shade700,
                        ),
                        title: Text(
                          'Book ID: ${swap.bookId}',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Status: ${swap.status}',
                          style: TextStyle(color: Colors.white70),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (swap.status == 'Pending') ...[
                              TextButton(
                                child: Text(
                                  "Accept",
                                  style: TextStyle(color: Colors.green),
                                ),
                                onPressed: () => swapProvider.updateSwapStatus(
                                  swap.id,
                                  "Accepted",
                                ),
                              ),
                              TextButton(
                                child: Text(
                                  "Reject",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () => swapProvider.updateSwapStatus(
                                  swap.id,
                                  "Rejected",
                                ),
                              ),
                            ],
                            IconButton(
                              icon: Icon(Icons.chat, color: Colors.blueAccent),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ChatScreen(chatId: swap.id),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () => swapProvider.deleteSwap(swap.id),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
      ],
    );
  }
}

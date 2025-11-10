import 'package:flutter/material.dart';
import 'browse_screen.dart';
import 'my_listings_screen.dart';
import 'chat_screen.dart';
import 'settings_screen.dart';

// Use BottomNavigationBar to persist navigation & always show appbar on all screens.

class MainAppScreen extends StatefulWidget {
  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    BrowseScreen(),
    MyListingsScreen(),
    ChatScreen(
      chatId: 'defaultChatId',
    ), // Replace 'defaultChatId' with an appropriate value
    SettingsScreen(),
  ];

  static final List<String> _titles = [
    'Browse Listings',
    'My Listings',
    'Chats',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex]), centerTitle: true),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF191A32),
        selectedItemColor: Color(0xFFFFD600),
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          setState(() {
            _selectedIndex = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Browse'),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'My Listings',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

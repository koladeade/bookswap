import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/books_provider.dart';
import 'providers/swap_provider.dart';
import 'screens/auth_screen.dart';
import 'screens/email_verify_screen.dart';
import 'screens/main_app_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BooksProvider()),
        ChangeNotifierProvider(create: (_) => SwapProvider()),
      ],
      child: BookSwapRootApp(),
    ),
  );
}

class BookSwapRootApp extends StatelessWidget {
  const BookSwapRootApp({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    Widget homeWidget = (auth.user == null)
        ? AuthScreen()
        : (auth.user!.emailVerified ? MainAppScreen() : EmailVerifyScreen());
    return MaterialApp(
      title: 'BookSwap',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF121329),
        scaffoldBackgroundColor: Color(0xFF121329),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFFFFD600),
          secondary: Colors.yellow.shade700,
          surface: Color(0xFF121329),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF191A32),
          foregroundColor: Colors.white,
          elevation: 1,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF191A32),
          selectedItemColor: Color(0xFFFFD600),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xFFFFD600)),
            foregroundColor: WidgetStatePropertyAll(Colors.black),
            minimumSize: WidgetStatePropertyAll(Size(56, 44)),
            textStyle: WidgetStatePropertyAll(
              TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),

      home: homeWidget,
    );
  }
}

# BookSwap
A Flutter app for students to swap books, manage listings, chat, and track swap offers in real time via Firebase.

# Features
1. Sign up, login, logout (Firebase Auth)

2. Post, edit, and delete books

3. Initiate swap offers with Pending/Accepted/Rejected state

4. See swaps you requested and offers for your books

5. Real-time message chat linked to swaps


bookswap/
├── ios/
├── lib/
├── firebase_options.dart
├── main.dart
├── models
│   ├── book.dart
│   └── swap.dart
├── providers
│   ├── auth_provider.dart
│   ├── books_provider.dart
│   └── swap_provider.dart
├── screens
│   ├── auth_screen.dart
│   ├── book_form_screen.dart
│   ├── browse_screen.dart
│   ├── chat_screen.dart
│   ├── email_verify_screen.dart
│   ├── main_app_screen.dart
│   ├── my_listings_screen.dart
│   └── settings_screen.dart
└── widgets
    └── swap_button.dart
├── pubspec.yaml
├── .gitignore
├── README.md


# Setup Instructions
1. Clone repo
  - git clone https://github.com/yourusername/bookswap.git
  - cd bookswap
  - Install dependencies (flutter pub get)
  - Add Firebase config files
  - Place GoogleService-Info.plist (iOS) in ios/Runner/

2. Set up Firebase

3. In the Firebase console: enable Email/Password Auth and Firestore Database

4. Run the app
  - flutter run
  - Build & Run
  - flutter pub get
  - flutter run

# Prerequisites
finEnsure the following are installed:
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Xcode (for iOS)](https://developer.apple.com/xcode/)
- [Android Studio or SDK tools](https://developer.android.com/studio)
- [Firebase CLI](https://firebase.google.com/docs/cli)



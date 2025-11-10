# BookSwap
A Flutter app for students to swap books, manage listings, chat, and track swap offers in real time via Firebase.

# Features
1. Sign up, login, logout (Firebase Auth)

2. Post, edit, and delete books

3. Initiate swap offers with Pending/Accepted/Rejected state

4. See swaps you requested and offers for your books

5. Real-time message chat linked to swaps

# Folder Structure

```
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
```

# Setup Instructions
1. Clone repo
  - git clone https://github.com/yourusername/bookswap.git
  - cd bookswap
  - Install dependencies (flutter pub get)
  - Add Firebase config files
  - Place GoogleService-Info.plist (iOS) in ios/Runner/


# Run the app
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

  # Architecture Design

<img width="1024" height="1536" alt="ChatGPT Image Nov 10, 2025, 10_58_02 AM" src="https://github.com/user-attachments/assets/beedf736-d77f-4dc2-8ed2-2d8493c5dabf" />

# Firebase Setup
1. Create Firebase Project
  - go to firebase console
  - click "add project"
  - enter project name: "bookswap"
  - disable google analytics (optional)
  - click "create project"
2. Register Your App
For Android:
  - in firebase console, click android icon
  - enter package name: com.example.bookswap
  - download google-services.json
  - place file in android/app/
  - update android/build.gradle:
```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.3.15'
    }
}
```

  - update android/app/build.gradle:
```gradle
plugins {
    id 'com.google.gms.google-services'
}
```
For iOS:
  - in firebase console, click ios icon
  - enter bundle id: com.example.bookswap
  - download GoogleService-Info.plist
  - place file in ios/Runner/

3. Enable Authentication
  - in firebase console, go to authentication
  - click "get started"
  - enable "email/password" sign-in method

4. Create Firestore Database
  - in firebase console, go to firestore database
  - click "create database"
  - start in test mode (change to production rules later)
  - choose a location close to your users
  - click "enable"

7. Initialize Firebase in Your App
  - The app is already configured to use firebase so after flutterfire cli is installed: dart pub global activate flutterfire_cli flutterfire configure


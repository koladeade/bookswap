#BookSwap
A Flutter app for students to swap books, manage listings, chat, and track swap offers in real time via Firebase.

#Features
1. Sign up, login, logout (Firebase Auth)

2. Post, edit, and delete books

3. Initiate swap offers with Pending/Accepted/Rejected state

4. See swaps you requested and offers for your books

5. Real-time message chat linked to swaps


Architecture
text
lib/
├── models/      # Book, Swap data classes
├── providers/   # AuthProvider, BooksProvider, SwapProvider (state management)
├── screens/     # UI screens (Browse, Listings, Settings, Chat, Auth, etc.)
├── widgets/     # Reusable widgets/components
└── main.dart    # App entry point
Data flow: UI → Providers ↔ Firebase (Firestore/Auth)

#Setup Instructions
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

5. Sensitive Files & .gitignore
  - Sensitive config files are excluded in .gitignore:

text
.dart_tool/
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
.env
firebase.json
build/
.idea/
Code Quality
Dart analyzer reports zero warnings with:

text
flutter analyze
# No issues found!
Architecture Diagram
text
[User UI]
   ↓↑
[Flutter Widgets]
   ↓↑ (Provider)
[Books/Auth/Swap Providers]
   ↓↑
[Firebase (Firestore, Auth)]

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isLoading = false;
  String errorMessage = '';

  AuthProvider() {
    user = _auth.currentUser;
    _auth.authStateChanges().listen((user) {
      this.user = user;
      notifyListeners();
    });
  }

  Future<void> signUp(String email, String password, String displayName) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = credential.user;
      await user!.sendEmailVerification();
      await user!.updateDisplayName(displayName);
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'uid': user!.uid,
        'email': email,
        'displayName': displayName,
      });
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message ?? 'Signup failed';
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = credential.user;
      if (!user!.emailVerified) {
        errorMessage = 'Email not verified. Check your inbox.';
        _auth.signOut();
      }
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message ?? 'Login failed';
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    user = null;
    notifyListeners();
  }

  Future<void> resendVerification() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
    }
  }
}

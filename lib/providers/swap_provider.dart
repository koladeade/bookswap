import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/swap.dart';

class SwapProvider with ChangeNotifier {
  List<Swap> _swapsSentByMe = [];
  List<Swap> _swapsForMyBooks = [];
  bool isLoading = false;

  List<Swap> get swapsSentByMe => _swapsSentByMe;
  List<Swap> get swapsForMyBooks => _swapsForMyBooks;

  // Fetch both sent and received swaps
  Future<void> fetchSwapsForUser(String userId) async {
    isLoading = true;
    notifyListeners();

    // Swaps sent by me
    FirebaseFirestore.instance
        .collection('swaps')
        .where('senderId', isEqualTo: userId)
        .snapshots()
        .listen((snapshot) {
          _swapsSentByMe = snapshot.docs
              .map((d) => Swap.fromMap(d.data(), d.id))
              .toList();
          notifyListeners();
        });

    // Swaps for my books (receiver)
    FirebaseFirestore.instance
        .collection('swaps')
        .where('recipientId', isEqualTo: userId)
        .snapshots()
        .listen((snapshot) {
          _swapsForMyBooks = snapshot.docs
              .map((d) => Swap.fromMap(d.data(), d.id))
              .toList();
          isLoading = false;
          notifyListeners();
        });
  }

  Future<void> requestSwap(Swap swap) async {
    await FirebaseFirestore.instance.collection('swaps').add(swap.toMap());
  }

  Future<void> updateSwapStatus(String swapId, String newStatus) async {
    await FirebaseFirestore.instance.collection('swaps').doc(swapId).update({
      'status': newStatus,
    });
  }

  Future<void> deleteSwap(String swapId) async {
    await FirebaseFirestore.instance.collection('swaps').doc(swapId).delete();
  }
}

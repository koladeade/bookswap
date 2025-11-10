import 'package:flutter/material.dart';

class SwapButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String status; // Pending, Accepted, Rejected, or empty

  SwapButton({required this.onPressed, required this.status});

  @override
  Widget build(BuildContext context) {
    final isPending = status == "Pending";
    return ElevatedButton(
      onPressed: isPending ? null : onPressed,
      child: Text(isPending ? 'Pending...' : 'Swap'),
    );
  }
}

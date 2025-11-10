import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({super.key});

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  bool resendLoading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            await auth.logout();
            // This will take the user back to AuthScreen (login/signup)!
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'A verification email has been sent to your inbox.\n\nPlease verify your email before logging in.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: resendLoading
                  ? null
                  : () async {
                      setState(() => resendLoading = true);
                      await auth.resendVerification();
                      setState(() => resendLoading = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Verification email resent!')),
                      );
                    },
              child: Text('Resend Verification Email'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => auth.logout(),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

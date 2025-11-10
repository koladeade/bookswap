import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool passwordVisible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFF121329),
      body: Center(
        child: Container(
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Icon(Icons.book, size: 64, color: Color(0xFFFFD600)),
              SizedBox(height: 24),
              Text(
                "BookSwap",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Swap Your Books With Other Students",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              SizedBox(height: 24),
              if (!isLogin)
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Display Name',
                    labelStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Color(0xFF20224A),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Color(0xFF20224A),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 12),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Color(0xFF20224A),
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Color(0xFFFFD600),
                    ),
                    onPressed: () =>
                        setState(() => passwordVisible = !passwordVisible),
                  ),
                ),
                obscureText: !passwordVisible,
                style: TextStyle(color: Colors.white),
              ),

              SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFFFFD600)),
                    foregroundColor: WidgetStatePropertyAll(Colors.black),
                  ),
                  onPressed: auth.isLoading
                      ? null
                      : () async {
                          if (isLogin) {
                            await auth.login(
                              emailController.text,
                              passwordController.text,
                            );
                          } else {
                            await auth.signUp(
                              emailController.text,
                              passwordController.text,
                              nameController.text,
                            );
                          }
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      isLogin ? 'Sign In' : 'Sign Up',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => setState(() => isLogin = !isLogin),
                child: Text(
                  isLogin
                      ? "Don't have an account? Sign up"
                      : "Already have an account? Log In",
                  style: TextStyle(
                    color: Color(0xFFFFD600),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (auth.errorMessage.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    auth.errorMessage,
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              if (auth.isLoading)
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: CircularProgressIndicator(color: Color(0xFFFFD600)),
                ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

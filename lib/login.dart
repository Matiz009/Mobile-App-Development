import 'package:appone/themeProvider.dart';
import 'package:appone/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int count = 0;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void loginUser(String email, String password) async {
    var user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    _showSnackBar('User created successfully with email: $user.email');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:
            theme.appBarTheme.backgroundColor ?? theme.primaryColor,
        title: Text(
          'Login',
          style: textTheme.titleLarge?.copyWith(
            color: theme.appBarTheme.foregroundColor ?? Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: themeProvider.toggleTheme,
            activeColor: Colors.white,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              TextField(
                controller: emailController,
                style: textTheme.bodyLarge,
                decoration: InputDecoration(
                  labelText: 'Enter you email',
                  hintText: 'Email',
                  border: const OutlineInputBorder(),
                  labelStyle: TextStyle(color: theme.hintColor),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: textTheme.bodyLarge,
                decoration: InputDecoration(
                  labelText: 'Enter your password',
                  hintText: 'Password',
                  border: const OutlineInputBorder(),
                  labelStyle: TextStyle(color: theme.hintColor),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();

                  if (email.isEmpty || password.isEmpty) {
                    _showSnackBar('Please fill in all fields.');
                    return;
                  }

                  loginUser(email, password);
                  emailController.clear();
                  passwordController.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Users(email: email),
                    ),
                  );
                },
                child: Text(
                  'Login',
                  style: textTheme.labelLarge?.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

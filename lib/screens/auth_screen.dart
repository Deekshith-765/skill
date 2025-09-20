import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // User logged in → go to HomeScreen
          return HomeScreen();
        } else {
          // Show login screen
          return Scaffold(
            appBar: AppBar(title: const Text("Login to SkillCycle")),
            body: Center(
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signInAnonymously();
                },
                child: const Text("Login (Anonymous)"),
              ),
            ),
          );
        }
      },
    );
  }
}

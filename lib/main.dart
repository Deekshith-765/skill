import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'screens/auth_screen.dart';
import 'screens/skills_screen.dart';
import 'providers/user_provider.dart';
import 'providers/skill_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDK1movts_7qfk8SpQvxXjSOzZ7yRWkV7U",
      appId: "1:703306560732:android:0ef377dbc24302f70d3019",
      messagingSenderId: "703306560732",
      projectId: "skillcycle-7",
      authDomain: "skillcycle-7.firebaseapp.com",
      storageBucket: "skillcycle-7.appspot.com",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => SkillProvider()),
      ],
      child: MaterialApp(
        title: 'SkillCycle',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasData) {
              return SkillsScreen();
            }
            return AuthScreen();
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:munchify/firebase_options.dart';
import 'package:munchify/login_page.dart';  // Importiere die LoginPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget ist the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),  // Setze die LoginPage als Startseite
    );
  }
}

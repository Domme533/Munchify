import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:munchify/active_tour_page.dart';
import 'package:munchify/firebase_options.dart';
import 'package:munchify/group_detail_page.dart';
import 'package:munchify/group_page_default.dart';
import 'package:munchify/login_page.dart';
import 'package:munchify/payment_page_order.dart';
import 'package:munchify/payment_page_runner.dart';
import 'package:munchify/start_page.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StartPage(),  // Setze die LoginPage als Startseite
    );
  }
}

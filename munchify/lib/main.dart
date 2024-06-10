import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:munchify/firebase_options.dart';
import 'package:munchify/screens/wrapper.dart';
import 'package:munchify/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:munchify/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //StreamProvider is a special type of provider that listens to changes on a Stream and updates dependents when the value of the Stream changes. In this case, we are listening to changes on the user Stream from AuthService.
    return StreamProvider<IUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Wrapper(),
      ),
    );
  }
}

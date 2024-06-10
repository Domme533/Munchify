import 'package:flutter/material.dart';
import 'package:munchify/screens/authenticate/sign_in.dart';
import 'package:munchify/test/testclass.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: SignIn(),
    );
  }
}
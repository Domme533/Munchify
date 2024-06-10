// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:munchify/screens/authenticate/sign_in.dart';
import 'package:munchify/screens/home/home.dart';
import 'package:munchify/services/auth.dart';
import 'package:munchify/shared/loading.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}
class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String error = ''; 
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: const Text('Register to Munchify'),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person),
            label: const Text('Sign In'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
            },
          )],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Center(
                child: Image.asset(
                'assets/images/Lunchify_Logo.png',
                width: 500,
                height: 500,
                ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
           ElevatedButton(
        child: const Text('Register'),
        onPressed: () async {
          SetState() => loading = true;
          dynamic result = await _auth.registerWithEmailAndPassword(_emailController.value.text, _passwordController.value.text);
          if (result != null) {
            setState(() {
              loading = false;
              print(result.toString());
            });
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
          }else {
            setState(() {
              loading = false;
              error = 'Please supply a valid email and password';
            });
          }
        },
      ),
      const SizedBox(height: 16.0),
      Text(error,
      style: const TextStyle(color: Colors.red),
      ),
          ],
        ),
      ),
    );
}}
import 'package:flutter/material.dart';
import 'package:munchify/screens/authenticate/register.dart';
import 'package:munchify/screens/home/home.dart';
import 'package:munchify/services/auth.dart';
import 'package:munchify/shared/loading.dart';
import 'package:munchify/test/testclass.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text('Sign in to Munchify'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Register()));
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Sign in'),
              onPressed: () async {
                setState(() => loading = true);
                dynamic result = await _auth.signInWithEmailAndPassword(
                    _emailController.value.text,
                    _passwordController.value.text);
                if (result != null) {
                  setState(() {
                    loading = false;
                  });
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                } else {
                  setState(() {
                    setState(() {
                      loading = false;
                    });
                    String error = 'Could not sign in with those credentials';
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

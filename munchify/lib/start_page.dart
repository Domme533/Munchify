import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Page'),
      ),
      body: Center(
        child: Text(
          'Welcome to Munchify!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

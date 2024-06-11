import 'package:munchify/models/group.dart';
import 'package:munchify/services/auth.dart';
import 'package:munchify/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class GroupList extends StatelessWidget {

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network('https://firebasestorage.googleapis.com/v0/b/lunchify-1f7b6.appspot.com/o/groupPictures%2FLunchify_Logo.png?alt=media&token=3b3b3b3b-3b3b-3b3b-3b3b-3b3b3b3b3b3b'),
            title: Text('Lunchify'),
          );
        });
  }
}
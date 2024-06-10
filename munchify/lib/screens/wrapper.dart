import 'package:flutter/material.dart';
import 'package:munchify/models/user.dart';
import 'package:munchify/screens/authenticate/authenticate.dart';
import 'package:munchify/screens/home/home.dart';
import 'package:munchify/test/testclass.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<IUser?>(context);

    //return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}

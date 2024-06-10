// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:munchify/screens/create_group/group_page_default.dart';
import 'package:munchify/services/auth.dart';
import 'package:munchify/services/database.dart';
import 'package:munchify/shared/loading.dart';

class CreateGroupPage extends StatefulWidget {
  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {

  final TextEditingController _groupNameController = TextEditingController();
  AuthService _auth = AuthService();
  bool loading = false;

  // Future<void> _pickLogoImage() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _logoImage = File(pickedFile.path);
  //     });
  //   }
  // }

  void _addUser(){
    
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Create Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Logo placeholder with upload functionality
            CircleAvatar(
              radius: 250,
              backgroundColor: Colors.grey[200],
              child: IconButton(
                icon: Icon(Icons.add_a_photo),
                onPressed: () {
                  DatabaseService(uid: _auth.getCurrentUser()).selectImage();
                },
              ),
            ),
            SizedBox(height: 20),
            
            // Name field
            TextField(
              controller: _groupNameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            
            // Users section
            
            SizedBox(height: 20),
            
            ElevatedButton(
                onPressed: () async {
                  setState(() => loading = true);
                  String groupid = await DatabaseService(uid: _auth.getCurrentUser()).createGroup(_groupNameController.text);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GroupPageDefault(groupid: groupid)));
                  setState (() => loading = false);
                },
                child: Text('Create Group'),
              ),
          ]
        ),
      ),
    );
  }
}

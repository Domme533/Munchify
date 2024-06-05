import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateGroupPage extends StatefulWidget {
  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  List<String> availableUsers = ['User 1', 'User 2', 'User 3', 'User 4'];
  List<String> selectedUsers = [];
  File? _logoImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickLogoImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _logoImage = File(pickedFile.path);
      });
    }
  }

  void _addUser() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: availableUsers.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(availableUsers[index]),
              onTap: () {
                setState(() {
                  selectedUsers.add(availableUsers[index]);
                  availableUsers.removeAt(index);
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            GestureDetector(
              onTap: _pickLogoImage,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: _logoImage != null ? FileImage(_logoImage!) : null,
                child: _logoImage == null ? Text('Logo') : null,
              ),
            ),
            SizedBox(height: 20),
            
            // Name field
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            
            // Users section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nutzer',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: selectedUsers.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(selectedUsers[index]),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: _addUser,
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            
            // Create Group button, visible only if 2 or more users are selected
            if (selectedUsers.length >= 2)
              ElevatedButton(
                onPressed: () {
                  // Your create group logic here
                },
                child: Text('Create Group'),
              ),
          ],
        ),
      ),
    );
  }
}

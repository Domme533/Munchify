// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:munchify/screens/authenticate/sign_in.dart';
import 'package:munchify/screens/create_group/create_group_page.dart';
import 'package:munchify/services/auth.dart';
import 'package:munchify/services/database.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final TextEditingController groupidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String uid = _auth.getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<int>(
          future: DatabaseService(uid: uid).getUserBalance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading balance...', style: TextStyle(fontSize: 15));
            } else if (snapshot.hasError) {
              return Text('Error loading balance', style: TextStyle(fontSize: 15));
            } else {
              return Text('Current Balance: ${snapshot.data} €', style: TextStyle(fontSize: 15));
            }
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset('assets/images/Lunchify_Logo.png', width: 200, height: 200),
            SizedBox(height: 20),

            // Gruppe Erstellen Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateGroupPage()));
                  },
                  child: Text('Gruppe erstellen'),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Join Group'),
                        content: TextField(
                          controller: groupidController,
                          decoration: InputDecoration(
                            hintText: 'Enter Group ID',
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await DatabaseService(uid: uid).joinGroup(groupidController.text);
                              Navigator.pop(context);
                            },
                            child: Text('Join Group'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text('Join Group'),
                ),
                ElevatedButton(
                  onPressed: () {
                    DatabaseService(uid: uid).getGroups();
                  },
                  child: Text('Test'),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search groups...',
                ),
                onChanged: (value) {
                  // Implement your search logic here
                },
              ),
            ),
            SizedBox(height: 20),

            // Groups Selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Your Groups',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),

                  // List of Groups
                  FutureBuilder<List<String>>(
                    future: DatabaseService(uid: uid).getGroups(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error loading groups');
                      } else {
                        final groups = snapshot.data ?? [];
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: groups.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                              future: DatabaseService(uid: uid).groupCollection.doc(groups[index]).get(),
                              builder: (context, groupSnapshot) {
                                if (groupSnapshot.connectionState == ConnectionState.waiting) {
                                  return ListTile(
                                    title: Text('Loading group...'),
                                  );
                                } else if (groupSnapshot.hasError) {
                                  return ListTile(
                                    title: Text('Error loading group'),
                                  );
                                } else {
                                  final groupData = groupSnapshot.data?.data();
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(groupData?['groupImage'] ?? 'https://via.placeholder.com/150'),
                                    ),
                                    title: Text(groupData?['groupName'] ?? 'Unknown Group'),
                                    subtitle: Text('Last Message'),
                                    onTap: () {
                                      // Implement your group selection logic here
                                    },
                                  );
                                }
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
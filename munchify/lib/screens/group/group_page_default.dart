// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:munchify/screens/home/home.dart';
import 'package:munchify/screens/tour/tour_config.dart';
import 'package:munchify/services/auth.dart';
import 'package:munchify/services/database.dart';

class GroupPageDefault extends StatefulWidget {
  final String groupid;
  GroupPageDefault({required this.groupid});

  @override
  _GroupPageDefaultState createState() => _GroupPageDefaultState(groupid: groupid);
}

class _GroupPageDefaultState extends State<GroupPageDefault> {
  final String groupid;
  final AuthService _auth = AuthService();
  late DatabaseService _dbService;
  List<Map<String, dynamic>> _recentTours = [];

  _GroupPageDefaultState({required this.groupid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.group,
                      size: 30,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    DatabaseService(uid: _auth.getCurrentUser()).groupCollection.doc(groupid).get().toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Recent Tours Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Recent Tours',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(thickness: 2),
                  SizedBox(height: 10),

                  // List of Tours
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _recentTours.length,
                    itemBuilder: (context, index) {
                      final tour = _recentTours[index];
                      return Card(
                        child: ListTile(
                          title: Text(tour['title'] ?? 'Tour ${index + 1}'),
                          subtitle: Text(tour['details'] ?? 'Details about tour ${index + 1}'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Start Tour
            ElevatedButton(
              onPressed: () {
                _dbService.startTour(groupid).then((_) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TourConfig(groupid: groupid)));
                });
              },
              child: Text('Start Tour'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:munchify/create_group_page.dart';

void main() {
  runApp(StartPage());
}

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset('assets/images/Lunchify_Logo.png', width: 200, height: 200),
            SizedBox(height: 20),

            // Gruppe Erstellen Button
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateGroupPage()));
                  },
                  child: Text('Gruppe erstellen'),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Letzte Gruppen Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Letzte Gruppen',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),

                  // List of Groups
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3, // Replace with the number of items you have
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text('Group ${index + 1}'),
                          subtitle: Text('Details about group ${index + 1}'),
                        ),
                      );
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

void createGroup(){
   
}
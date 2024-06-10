// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class GroupDetailPage extends StatelessWidget {
  const GroupDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DetailPage(),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Group Name Placeholder
              Row(
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
                    'Bsp. Gruppe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Letzte Tour Section
              Text(
                'Letzte Tour:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              // Bestellung Section
              Text(
                'Bestellung:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Details about the order'),
                ),
              ),
              SizedBox(height: 10),

              // Kosten Section
              Text(
                'Kosten:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Details about the cost'),
                ),
              ),
              SizedBox(height: 10),

              // Läufer Section
              Text(
                'Läufer: Max M.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(thickness: 2),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

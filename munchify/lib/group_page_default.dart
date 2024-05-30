import 'package:flutter/material.dart';

class GroupPageDefault extends StatelessWidget {
  const GroupPageDefault({super.key}) ;
  @override
   Widget build(BuildContext context) {
    return MaterialApp(
      home: GroupPage(),
    );
  }
}

class GroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Group Name Placeholder
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
                    'Bsp. Gruppe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Letzte Touren Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Letzte Touren',
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
                    itemCount: 2, // Replace with the number of items you have
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text('Tour ${index + 1}'),
                          subtitle: Text('Details about tour ${index + 1}'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Tour Starten Button
            ElevatedButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              child: Text('Tour Starten'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
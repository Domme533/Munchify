import 'package:flutter/material.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      home: ActiveTourPage(),
    );
  }
}

class ActiveTourPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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

            // Einkaufsliste Section
            Text(
              'Einkaufsliste:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Einkaufsliste List
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Replace with the number of items you have
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: false, // Replace with your own logic
                        onChanged: (bool? value) {
                          // Handle checkbox change
                        },
                      ),
                      title: Text('Item ${index + 1}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('1x'), // Replace with actual quantity
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              // Handle remove item from list
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Tour beenden Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add your onPressed code here!
                },
                child: Text('Tour beenden'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
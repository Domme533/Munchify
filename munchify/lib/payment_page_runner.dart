// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const PaymentPageRunner());
}

class PaymentPageRunner extends StatelessWidget {
  const PaymentPageRunner({super.key});

  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      home: CompletedTourPage(),
    );
  }
}

class CompletedTourPage extends StatelessWidget {
  final bool moneyReceived = true; // Example variable to show the button

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

            // List of Items with Cost and Checkmark
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Replace with the number of items you have
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          Icons.shopping_cart,
                          size: 20,
                          color: Colors.grey[800],
                        ),
                      ),
                      title: Text('Item ${index + 1}'),
                      subtitle: Text('${(index + 1) * 1.25} €'),
                      trailing: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Total Amount and Remaining Amount
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Gesamtbetrag: 21.89 €\nnoch fehlend: 11.89 €',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Abschluss Button (Visible when moneyReceived is true)
            Visibility(
              visible: moneyReceived,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                  child: Text('Abschließen'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
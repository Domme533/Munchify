// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PaymentPageOrder extends StatefulWidget {
  @override
  _PaymentPageOrderState createState() => _PaymentPageOrderState();
}

class _PaymentPageOrderState extends State<PaymentPageOrder> {
  @override
Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  // Clock Icon Placeholder
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.access_time,
                      size: 50,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Sie schulden\nMax 2.19€',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Ihre Bestellung Section
            Text(
              'Ihre Bestellung:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // List of Orders
            Card(
              child: ListTile(
                title: Text('2x Brezel'),
                trailing: Text('0.78€'),
              ),
            ),
            // Add more orders if necessary
            SizedBox(height: 20),

            // Guthaben verwenden Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add your onPressed code here!
                },
                child: Text('Guthaben verwenden'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
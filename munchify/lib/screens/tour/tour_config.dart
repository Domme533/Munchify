import 'dart:async';
import 'package:flutter/material.dart';
import 'package:munchify/services/database.dart';
import 'package:munchify/services/auth.dart';

class TourConfig extends StatefulWidget {
  final String groupid;
  @override
  _TourConfigState createState() => _TourConfigState(groupid: groupid);
  TourConfig({required this.groupid});
}

class _TourConfigState extends State<TourConfig> {
  final TextEditingController _inputController1 = TextEditingController();
  bool _notifyUsers = true;
  Duration _timerDuration = Duration();
  Timer? _timer;
  final AuthService _auth = AuthService();
  final String groupid;

  _TourConfigState({required this.groupid});
  
  @override

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    setState(() {
      _timerDuration = Duration(minutes: int.tryParse(_inputController1.text) ?? 0);
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timerDuration.inSeconds <= 0) {
        timer.cancel();
      } else {
        setState(() {
          _timerDuration -= Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _inputController1.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String uid = _auth.getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        title: Text('Tour Config'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Logo
            CircleAvatar(
              radius: 40,
              child: Text('Logo'),
            ),
            SizedBox(height: 20),
            
            // Input 1
            TextField(
              controller: _inputController1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Shopping Destination',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            
            
            // Notify Users
            Row(
              children: [
                Checkbox(
                  value: _notifyUsers,
                  onChanged: (value) {
                    setState(() {
                      _notifyUsers = value!;
                    });
                  },
                ),
                Text('Notify Users'),
              ],
            ),
            SizedBox(height: 20),
            
            // Timer Display
            Text(
              '${_timerDuration.inMinutes}:${(_timerDuration.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20),
            
            // Start Button
            ElevatedButton(
              onPressed: () {
                _startTimer();
                DatabaseService(uid: uid).startTour(groupid);
              },
              child: Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}

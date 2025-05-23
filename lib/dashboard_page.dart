import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to your Dashboard',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to scan page
              },
              child: Text('Scan Items'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to leaderboard
              },
              child: Text('Leaderboard'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to profile
              },
              child: Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/user_model.dart';
import 'theme/app_theme.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Mock user data - in a real app, this would come from a provider or service
  final User _user = User(
    id: '1',
    name: 'Emma J.',
    email: 'emma@example.com',
    points: 120,
  );

  // Mock leaderboard data
  final List<Map<String, dynamic>> _leaderboard = [
    {'id': '1', 'name': 'Sophie W.', 'points': 2160, 'image': 'assets/user1.jpg'},
    {'id': '2', 'name': 'Daniel M.', 'points': 1840, 'image': 'assets/user2.jpg'},
    {'id': '3', 'name': 'Emma J.', 'points': 120, 'image': 'assets/profile.jpg'},
    {'id': '4', 'name': 'Olivia K.', 'points': 930, 'image': 'assets/user3.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              HapticFeedback.mediumImpact();
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            _buildPointsCard(),
            _buildLeaderboard(),
          ],
        ),
      ),
      // Remove bottom navigation bar as it's not needed in profile page and causes double navbar issue
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/profile.jpg'),
            backgroundColor: Colors.grey.shade800,
            onBackgroundImageError: (exception, stackTrace) {
              // Fallback for missing image
              return;
            },
            child: Icon(Icons.person, size: 50, color: Colors.grey),
          ),
          SizedBox(height: 16),
          Text(
            _user.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 4),
          Text(
            _user.email,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade900,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Points',
                style: TextStyle(fontSize: 16, color: Colors.green.shade100),
              ),
              SizedBox(height: 8),
              Text(
                '${_user.points}',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Redeem'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboard() {
    return Container(
      margin: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Leaderboard',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 16),
          ..._leaderboard.map((user) => _buildLeaderboardItem(user)).toList(),
        ],
      ),
    );
  }

  Widget _buildLeaderboardItem(Map<String, dynamic> user) {
    final bool isCurrentUser = user['name'] == _user.name;
    
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.green.withOpacity(0.2) : Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        border: isCurrentUser ? Border.all(color: Colors.green, width: 1) : null,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(user['image']),
            backgroundColor: Colors.grey.shade800,
            onBackgroundImageError: (exception, stackTrace) {
              // Fallback for missing image
              return;
            },
            child: Icon(Icons.person, size: 20, color: Colors.grey),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              user['name'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            '${user['points']}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isCurrentUser ? Colors.green : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  List<User> _weeklyLeaders = [];
  List<User> _monthlyLeaders = [];
  List<User> _allTimeLeaders = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadLeaderboardData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadLeaderboardData() async {
    // In a real app, this would fetch data from a database or API
    // For demo purposes, we'll use sample data
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    // Create sample users for the leaderboard
    final sampleUsers = [
      User(id: '1', name: 'Emma J.', email: 'emma@example.com', points: 120),
      User(id: '2', name: 'John D.', email: 'john@example.com', points: 180),
      User(id: '3', name: 'Sarah M.', email: 'sarah@example.com', points: 150),
      User(id: '4', name: 'Michael B.', email: 'michael@example.com', points: 200),
      User(id: '5', name: 'Lisa K.', email: 'lisa@example.com', points: 90),
      User(id: '6', name: 'David W.', email: 'david@example.com', points: 110),
      User(id: '7', name: 'Jessica T.', email: 'jessica@example.com', points: 170),
      User(id: '8', name: 'Robert S.', email: 'robert@example.com', points: 130),
      User(id: '9', name: 'Amanda P.', email: 'amanda@example.com', points: 160),
      User(id: '10', name: 'Daniel L.', email: 'daniel@example.com', points: 140),
    ];

    // Sort users by points (descending)
    sampleUsers.sort((a, b) => b.points.compareTo(a.points));

    // Create different variations for weekly and monthly
    final weeklyUsers = List<User>.from(sampleUsers);
    weeklyUsers.shuffle();
    weeklyUsers.sort((a, b) => b.points.compareTo(a.points));

    final monthlyUsers = List<User>.from(sampleUsers);
    monthlyUsers.shuffle();
    monthlyUsers.sort((a, b) => b.points.compareTo(a.points));

    setState(() {
      _weeklyLeaders = weeklyUsers;
      _monthlyLeaders = monthlyUsers;
      _allTimeLeaders = sampleUsers;
      _isLoading = false;
    });
  }

  Widget _buildLeaderboardList(List<User> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final rank = index + 1;
        
        // Determine medal color for top 3
        Color? medalColor;
        IconData medalIcon = Icons.emoji_events;
        
        if (rank == 1) {
          medalColor = Colors.amber; // Gold
        } else if (rank == 2) {
          medalColor = Colors.grey.shade400; // Silver
        } else if (rank == 3) {
          medalColor = Colors.brown.shade300; // Bronze
        }

        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green.shade50,
              child: medalColor != null 
                ? Icon(medalIcon, color: medalColor)
                : Text(rank.toString()),
            ),
            title: Text(user.name),
            subtitle: Text('${user.points} points'),
            trailing: rank <= 3 
              ? Text(
                  '#$rank',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: medalColor,
                  ),
                )
              : Text('#$rank'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Weekly'),
            Tab(text: 'Monthly'),
            Tab(text: 'All Time'),
          ],
        ),
      ),
      body: _isLoading
        ? Center(child: CircularProgressIndicator())
        : TabBarView(
            controller: _tabController,
            children: [
              _buildLeaderboardList(_weeklyLeaders),
              _buildLeaderboardList(_monthlyLeaders),
              _buildLeaderboardList(_allTimeLeaders),
            ],
          ),
    );
  }
}
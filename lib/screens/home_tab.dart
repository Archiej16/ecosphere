import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/user_model.dart';
import '../models/recycling_item.dart';
import '../theme/app_theme.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  // Mock user data - in a real app, this would come from a provider or service
  final User _user = User(
    id: '1',
    name: 'Clawrence',
    email: 'clawrence@example.com',
    points: 100,
  );

  // Mock mission data
  final Map<String, dynamic> _currentMission = {
    'title': 'Recycle 5 plastic',
    'points': 100,
    'image': 'assets/plastic_bottle.png',
  };

  // Mock history data
  final List<Map<String, dynamic>> _recyclingHistory = [
    {
      'id': '1',
      'date': DateTime.now().subtract(Duration(days: 1)),
      'item': 'Plastic Bag',
      'points': 10,
      'image': 'assets/plastic_bag.png',
    },
    {
      'id': '2',
      'date': DateTime.now().subtract(Duration(days: 2)),
      'item': 'Glass Bottle',
      'points': 15,
      'image': 'assets/glass_bottle.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User greeting
                _buildUserGreeting(),
                SizedBox(height: 20),
                
                // Category buttons
                _buildCategoryButtons(),
                SizedBox(height: 24),
                
                // Current mission
                _buildMissionSection(),
                SizedBox(height: 24),
                
                // History section
                _buildHistorySection(),
              ],
            ),
          ),
        ),
      ),
      // Bottom navigation bar is handled in main_tab_controller.dart
    );
  }

  Widget _buildUserGreeting() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, ${_user.name}!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Let\'s contribute to our earth.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.notifications_none),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildCategoryButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _categoryButton(Icons.eco, 'Paper', Colors.green.shade100),
        _categoryButton(Icons.volume_up, 'Glass', Colors.blue.shade100),
        _categoryButton(Icons.local_drink, 'Plastic', Colors.green.shade200),
        _categoryButton(Icons.battery_full, 'Metal', Colors.orange.shade100),
      ],
    );
  }

  Widget _categoryButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: Colors.green.shade800),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildMissionSection() {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Your Mission',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('More missions coming soon!'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                );
              },
              child: Text('Show more'),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Theme.of(context).cardTheme.color : Colors.green.shade100,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recycle 5 plastic items',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          SizedBox(width: 4),
                          Text(
                            'EARN 100 POINTS',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.green.shade300 : Colors.green.shade800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          HapticFeedback.mediumImpact();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Scan items to complete this mission'),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          );
                        },
                        child: Text('Earn now'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDarkMode ? Theme.of(context).primaryColor : Colors.white,
                          foregroundColor: isDarkMode ? Colors.white : Colors.green.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/plasticbottle.jpg',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.local_drink, size: 80, color: Colors.green.shade800);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('View all activity'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                );
              },
              child: Text('View all'),
            ),
          ],
        ),
        SizedBox(height: 10),
        ..._recyclingHistory.map((item) => _buildHistoryItem(item)).toList(),
      ],
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Provider.of<ThemeProvider>(context).isDarkMode 
          ? Theme.of(context).cardTheme.color
          : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Provider.of<ThemeProvider>(context).isDarkMode 
                ? Colors.green.shade900.withOpacity(0.3)
                : Colors.green.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: item['item'] == 'Plastic Bag' 
                ? Image.asset(
                    'assets/images/plasticbag.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.recycling, color: Colors.green);
                    },
                  )
                : Image.asset(
                    'assets/images/recycle.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.recycling, color: Colors.green);
                    },
                  ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['item'] as String,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${(item['date'] as DateTime).day}/${(item['date'] as DateTime).month}/${(item['date'] as DateTime).year}',
                  style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7), fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Provider.of<ThemeProvider>(context).isDarkMode 
                ? Colors.green.shade900.withOpacity(0.3)
                : Colors.green.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Colors.amber, size: 14),
                SizedBox(width: 4),
                Text(
                  '+${item["points"]}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bottom navigation bar is already handled in main_tab_controller.dart
  // This prevents the double navbar issue
}
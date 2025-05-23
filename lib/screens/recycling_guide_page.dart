import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecyclingGuidePage extends StatefulWidget {
  @override
  _RecyclingGuidePageState createState() => _RecyclingGuidePageState();
}

class _RecyclingGuidePageState extends State<RecyclingGuidePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> _materials = [
    {
      'name': 'Plastic',
      'icon': Icons.local_drink,
      'color': Colors.blue,
      'items': [
        {
          'name': 'PET Bottles',
          'recyclable': true,
          'instructions': 'Rinse, remove cap, and flatten before recycling',
          'image': 'assets/images/plasticbottle.jpg',
        },
        {
          'name': 'Plastic Bags',
          'recyclable': false,
          'instructions': 'Take to store collection points, not for curbside recycling',
          'image': 'assets/images/plasticbag.jpg',
        },
      ],
    },
    {
      'name': 'Paper',
      'icon': Icons.article,
      'color': Colors.amber,
      'items': [
        {
          'name': 'Newspapers',
          'recyclable': true,
          'instructions': 'Keep dry and bundle together',
          'image': 'assets/images/recycle.jpg',
        },
        {
          'name': 'Pizza Boxes',
          'recyclable': false,
          'instructions': 'Food-soiled paper cannot be recycled',
          'image': 'assets/images/recycle.jpg',
        },
      ],
    },
    {
      'name': 'Glass',
      'icon': Icons.wine_bar,
      'color': Colors.green,
      'items': [
        {
          'name': 'Glass Bottles',
          'recyclable': true,
          'instructions': 'Rinse thoroughly, remove caps and corks',
          'image': 'assets/images/recycle.jpg',
        },
      ],
    },
    {
      'name': 'Metal',
      'icon': Icons.settings,
      'color': Colors.grey,
      'items': [
        {
          'name': 'Aluminum Cans',
          'recyclable': true,
          'instructions': 'Rinse and crush to save space',
          'image': 'assets/images/recycle.jpg',
        },
      ],
    },
    {
      'name': 'DIY',
      'icon': Icons.handyman,
      'color': Colors.purple,
      'items': [
        {
          'name': 'Bottle Planters',
          'instructions': 'Cut plastic bottles to create small planters',
          'image': 'assets/images/diy bottles.jpg',
        },
        {
          'name': 'Bottle Cap Art',
          'instructions': 'Collect bottle caps to create colorful mosaics',
          'image': 'assets/images/diy caps.jpg',
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _materials.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Recycling Guide'),
        backgroundColor: Colors.green,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          tabs: _materials.map((material) {
            return Tab(
              icon: Icon(material['icon'] as IconData),
              text: material['name'] as String,
            );
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _materials.map((material) {
          return _buildMaterialTab(material);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.mediumImpact();
          _showSearchDialog();
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.search),
        tooltip: 'Search recyclable items',
      ),
    );
  }

  Widget _buildMaterialTab(Map<String, dynamic> material) {
    final items = material['items'] as List<Map<String, dynamic>>;
    
    return Container(
      color: Colors.black,
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _buildItemCard(item, material['color'] as Color);
        },
      ),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item, Color color) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image section
            Stack(
              alignment: Alignment.topRight,
              children: [
                Image.asset(
                  item['image'] as String,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      color: color.withOpacity(0.2),
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: color,
                      ),
                    );
                  },
                ),
                if (item.containsKey('recyclable'))
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: item['recyclable'] ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      item['recyclable'] ? 'Recyclable' : 'Not Recyclable',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            // Content section
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'] as String,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item['instructions'] as String,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildActionButton(
                        icon: Icons.info_outline,
                        label: 'More Info',
                        onTap: () => _showItemDetails(item),
                      ),
                      SizedBox(width: 8),
                      _buildActionButton(
                        icon: Icons.share,
                        label: 'Share',
                        onTap: () {
                          HapticFeedback.lightImpact();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Sharing ${item['name']}...'),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: Colors.green),
            SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showItemDetails(Map<String, dynamic> item) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (_, controller) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: EdgeInsets.all(20),
            child: ListView(
              controller: controller,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
                // Title
                Text(
                  item['name'] as String,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item['image'] as String,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                // Detailed instructions
                Text(
                  'Instructions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  item['instructions'] as String,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                // Additional information
                if (item.containsKey('recyclable'))
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: item['recyclable'] ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          item['recyclable'] ? Icons.check_circle : Icons.cancel,
                          color: item['recyclable'] ? Colors.green : Colors.red,
                          size: 24,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item['recyclable']
                                ? 'This item is recyclable in most curbside programs.'
                                : 'This item is typically not accepted in curbside recycling programs.',
                            style: TextStyle(
                              fontSize: 16,
                              color: item['recyclable'] ? Colors.green[800] : Colors.red[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 30),
                // Close button
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Search Recyclable Items'),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Enter item name...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onSubmitted: (value) {
            Navigator.pop(context);
            if (value.isNotEmpty) {
              _performSearch(value);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Search'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  void _performSearch(String query) {
    // In a real app, this would search through a database
    // For now, just show a snackbar with the search term
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Searching for "$query"...'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
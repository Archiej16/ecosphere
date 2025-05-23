
import 'package:flutter/material.dart';

class VolunteerTab extends StatefulWidget {
  @override
  _VolunteerTabState createState() => _VolunteerTabState();
}

class _VolunteerTabState extends State<VolunteerTab> {
  // Mock data for volunteer section
  final List<Map<String, dynamic>> _participants = [
    {'id': '1', 'image': 'assets/participant1.jpg'},
    {'id': '2', 'image': 'assets/participant2.jpg'},
    {'id': '3', 'image': 'assets/participant3.jpg'},
    {'id': '4', 'image': 'assets/participant4.jpg'},
    {'id': '5', 'image': 'assets/participant5.jpg'},
  ];

  final List<Map<String, dynamic>> _activities = [
    {'id': '1', 'image': 'assets/activity1.jpg'},
    {'id': '2', 'image': 'assets/activity2.jpg'},
    {'id': '3', 'image': 'assets/activity3.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Green recycling symbol background
            _buildHeader(),
            
            // Volunteer information card
            _buildVolunteerInfoCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.green,
      child: Center(
        child: Icon(
          Icons.recycling,
          size: 100,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildVolunteerInfoCard() {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How to be a volunteer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry\'s standard.',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            SizedBox(height: 24),
            Text(
              'Benefit',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            _buildBenefitItem(
              icon: Icons.star,
              text: 'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
            ),
            SizedBox(height: 8),
            _buildBenefitItem(
              icon: Icons.check_circle,
              text: 'Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s.',
            ),
            TextButton(
              onPressed: () {},
              child: Text('Read more'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Participant',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Activity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Participants
                _buildParticipantsList(),
                
                // Activities
                _buildActivitiesList(),
              ],
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Join Volunteer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem({required IconData icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.amber, size: 20),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantsList() {
    return SizedBox(
      width: 150,
      height: 40,
      child: Stack(
        children: List.generate(_participants.length, (index) {
          return Positioned(
            left: index * 25.0,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(_participants[index]['image']),
                onBackgroundImageError: (exception, stackTrace) {
                  // Fallback for missing images
                  return;
                },
                child: ClipOval(
                  child: Icon(
                    Icons.person,
                    color: Colors.grey.shade300,
                    size: 20,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildActivitiesList() {
    return Row(
      children: _activities.map((activity) {
        return Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(activity['image']),
              fit: BoxFit.cover,
              onError: (exception, stackTrace) {
                // Fallback for missing images
                return;
              },
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: Colors.grey.shade200,
              child: Icon(Icons.image, color: Colors.grey),
            ),
          ),
        );
      }).toList(),
    );
  }
}
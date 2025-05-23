import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/recycling_center.dart';

class RecyclingCentersMap extends StatefulWidget {
  @override
  _RecyclingCentersMapState createState() => _RecyclingCentersMapState();
}

class _RecyclingCentersMapState extends State<RecyclingCentersMap> {
  GoogleMapController? _mapController;
  List<RecyclingCenter> _centers = [];
  Set<Marker> _markers = {};
  RecyclingCenter? _selectedCenter;
  bool _isLoading = true;

  // Initial camera position (will be updated with user's location in a real app)
  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // San Francisco coordinates
    zoom: 12.0,
  );

  @override
  void initState() {
    super.initState();
    _loadRecyclingCenters();
  }

  Future<void> _loadRecyclingCenters() async {
    // In a real app, this would fetch data from an API or database
    // For demo purposes, we'll use sample data
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    final centers = RecyclingCenter.getSampleCenters();
    final markers = centers.map((center) {
      return Marker(
        markerId: MarkerId(center.id),
        position: LatLng(center.latitude, center.longitude),
        infoWindow: InfoWindow(title: center.name),
        onTap: () {
          setState(() {
            _selectedCenter = center;
          });
        },
      );
    }).toSet();

    setState(() {
      _centers = centers;
      _markers = markers;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recycling Centers'),
      ),
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            initialCameraPosition: _initialPosition,
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
          ),
          
          // Loading indicator
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            
          // Selected center details
          if (_selectedCenter != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedCenter!.name,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(_selectedCenter!.address),
                    SizedBox(height: 4),
                    Text('Hours: ${_selectedCenter!.operatingHours}'),
                    SizedBox(height: 8),
                    Text(
                      'Accepted Items:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      spacing: 8,
                      children: _selectedCenter!.acceptedItems.map((item) {
                        return Chip(
                          label: Text(item),
                          backgroundColor: Colors.green.shade100,
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_selectedCenter!.phoneNumber.isNotEmpty)
                          TextButton.icon(
                            onPressed: () {
                              // In a real app, this would launch the phone app
                            },
                            icon: Icon(Icons.phone),
                            label: Text('Call'),
                          ),
                        if (_selectedCenter!.website.isNotEmpty)
                          TextButton.icon(
                            onPressed: () {
                              // In a real app, this would launch the website
                            },
                            icon: Icon(Icons.language),
                            label: Text('Website'),
                          ),
                        TextButton.icon(
                          onPressed: () {
                            // In a real app, this would launch maps for directions
                          },
                          icon: Icon(Icons.directions),
                          label: Text('Directions'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // In a real app, this would center the map on the user's current location
          _mapController?.animateCamera(
            CameraUpdate.newCameraPosition(_initialPosition),
          );
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}
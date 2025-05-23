class RecyclingCenter {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String phoneNumber;
  final String website;
  final List<String> acceptedItems;
  final String operatingHours;

  RecyclingCenter({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.phoneNumber = '',
    this.website = '',
    required this.acceptedItems,
    required this.operatingHours,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'phoneNumber': phoneNumber,
      'website': website,
      'acceptedItems': acceptedItems,
      'operatingHours': operatingHours,
    };
  }

  factory RecyclingCenter.fromMap(Map<String, dynamic> map) {
    return RecyclingCenter(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      latitude: map['latitude'] ?? 0.0,
      longitude: map['longitude'] ?? 0.0,
      phoneNumber: map['phoneNumber'] ?? '',
      website: map['website'] ?? '',
      acceptedItems: List<String>.from(map['acceptedItems'] ?? []),
      operatingHours: map['operatingHours'] ?? '',
    );
  }

  // Sample recycling centers for testing
  static List<RecyclingCenter> getSampleCenters() {
    return [
      RecyclingCenter(
        id: '1',
        name: 'Green Earth Recycling',
        address: '123 Eco Street, Green City',
        latitude: 37.7749,
        longitude: -122.4194,
        phoneNumber: '(555) 123-4567',
        website: 'www.greenearthrecycling.com',
        acceptedItems: ['Plastic', 'Paper', 'Glass', 'Metal'],
        operatingHours: 'Mon-Fri: 8AM-6PM, Sat: 9AM-4PM',
      ),
      RecyclingCenter(
        id: '2',
        name: 'City Recycling Center',
        address: '456 Urban Ave, Metro City',
        latitude: 37.7833,
        longitude: -122.4167,
        phoneNumber: '(555) 987-6543',
        website: 'www.cityrecycling.org',
        acceptedItems: ['Plastic', 'Paper', 'Electronics', 'Batteries'],
        operatingHours: 'Mon-Sat: 7AM-7PM',
      ),
      RecyclingCenter(
        id: '3',
        name: 'EcoFriendly Disposal',
        address: '789 Nature Blvd, Eco Town',
        latitude: 37.7694,
        longitude: -122.4862,
        phoneNumber: '(555) 456-7890',
        website: 'www.ecofriendlydisposal.com',
        acceptedItems: ['Hazardous Waste', 'Electronics', 'Appliances', 'Metal'],
        operatingHours: 'Tue-Sun: 9AM-5PM',
      ),
    ];
  }
}
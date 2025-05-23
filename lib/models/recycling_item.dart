class RecyclingItem {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final int pointsValue;
  final int carbonSaved;
  final String recyclingInstructions;
  final bool isRecyclable;

  RecyclingItem({
    required this.id,
    required this.name,
    required this.category,
    this.imageUrl = '',
    required this.pointsValue,
    required this.carbonSaved,
    required this.recyclingInstructions,
    required this.isRecyclable,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'imageUrl': imageUrl,
      'pointsValue': pointsValue,
      'carbonSaved': carbonSaved,
      'recyclingInstructions': recyclingInstructions,
      'isRecyclable': isRecyclable,
    };
  }

  factory RecyclingItem.fromMap(Map<String, dynamic> map) {
    return RecyclingItem(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      pointsValue: map['pointsValue'] ?? 0,
      carbonSaved: map['carbonSaved'] ?? 0,
      recyclingInstructions: map['recyclingInstructions'] ?? '',
      isRecyclable: map['isRecyclable'] ?? false,
    );
  }

  // Sample items for testing
  static List<RecyclingItem> getSampleItems() {
    return [
      RecyclingItem(
        id: '1',
        name: 'Plastic Bottle',
        category: 'Plastic',
        pointsValue: 5,
        carbonSaved: 10,
        recyclingInstructions: 'Rinse, remove cap, and place in recycling bin',
        isRecyclable: true,
      ),
      RecyclingItem(
        id: '2',
        name: 'Aluminum Can',
        category: 'Metal',
        pointsValue: 10,
        carbonSaved: 15,
        recyclingInstructions: 'Rinse and place in recycling bin',
        isRecyclable: true,
      ),
      RecyclingItem(
        id: '3',
        name: 'Glass Bottle',
        category: 'Glass',
        pointsValue: 8,
        carbonSaved: 12,
        recyclingInstructions: 'Rinse, remove cap, and place in recycling bin',
        isRecyclable: true,
      ),
      RecyclingItem(
        id: '4',
        name: 'Cardboard Box',
        category: 'Paper',
        pointsValue: 7,
        carbonSaved: 8,
        recyclingInstructions: 'Flatten and place in recycling bin',
        isRecyclable: true,
      ),
      RecyclingItem(
        id: '5',
        name: 'Styrofoam Container',
        category: 'Plastic',
        pointsValue: 0,
        carbonSaved: 0,
        recyclingInstructions: 'Not recyclable in most areas. Check local guidelines.',
        isRecyclable: false,
      ),
    ];
  }
}
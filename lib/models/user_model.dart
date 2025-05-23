class User {
  final String id;
  final String name;
  final String email;
  final String profileImageUrl;
  final int points;
  final int carbonFootprint;
  final List<String> recycledItems;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImageUrl = '',
    this.points = 0,
    this.carbonFootprint = 0,
    this.recycledItems = const [],
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImageUrl,
    int? points,
    int? carbonFootprint,
    List<String>? recycledItems,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      points: points ?? this.points,
      carbonFootprint: carbonFootprint ?? this.carbonFootprint,
      recycledItems: recycledItems ?? this.recycledItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'points': points,
      'carbonFootprint': carbonFootprint,
      'recycledItems': recycledItems,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
      points: map['points'] ?? 0,
      carbonFootprint: map['carbonFootprint'] ?? 0,
      recycledItems: List<String>.from(map['recycledItems'] ?? []),
    );
  }
}
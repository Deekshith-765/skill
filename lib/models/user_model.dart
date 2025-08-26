class UserModel {
  final String id;
  final String email;
  final String? displayName;
  final String? phoneNumber;
  final String? photoUrl;
  final double rating;
  final int completedTasks;
  final DateTime createdAt;
  final List<String> skills;
  final double walletBalance;

  UserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.phoneNumber,
    this.photoUrl,
    this.rating = 5.0,
    this.completedTasks = 0,
    required this.createdAt,
    this.skills = const [],
    this.walletBalance = 0.0,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      email: map['email'] ?? '',
      displayName: map['displayName'],
      phoneNumber: map['phoneNumber'],
      photoUrl: map['photoUrl'],
      rating: (map['rating'] ?? 5.0).toDouble(),
      completedTasks: map['completedTasks'] ?? 0,
      createdAt: DateTime.parse(map['createdAt']),
      skills: List<String>.from(map['skills'] ?? []),
      walletBalance: (map['walletBalance'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'rating': rating,
      'completedTasks': completedTasks,
      'createdAt': createdAt.toIso8601String(),
      'skills': skills,
      'walletBalance': walletBalance,
    };
  }
}

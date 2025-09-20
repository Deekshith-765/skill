class SkillModel {
  final String id;
  final String userId;
  final String title;
  final String description;
  final List<String> categories;
  final double price;
  final String priceType; // hourly, fixed, negotiable
  final List<String> images;
  final double rating;
  final int totalReviews;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String location;
  final List<String> tags;

  SkillModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.categories,
    required this.price,
    required this.priceType,
    this.images = const [],
    this.rating = 0.0,
    this.totalReviews = 0,
    this.isAvailable = true,
    required this.createdAt,
    required this.updatedAt,
    this.location = '',
    this.tags = const [],
  });

  factory SkillModel.fromMap(Map<String, dynamic> map, String id) {
    return SkillModel(
      id: id,
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      categories: List<String>.from(map['categories'] ?? []),
      price: (map['price'] ?? 0.0).toDouble(),
      priceType: map['priceType'] ?? 'fixed',
      images: List<String>.from(map['images'] ?? []),
      rating: (map['rating'] ?? 0.0).toDouble(),
      totalReviews: map['totalReviews'] ?? 0,
      isAvailable: map['isAvailable'] ?? true,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      location: map['location'] ?? '',
      tags: List<String>.from(map['tags'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'categories': categories,
      'price': price,
      'priceType': priceType,
      'images': images,
      'rating': rating,
      'totalReviews': totalReviews,
      'isAvailable': isAvailable,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'location': location,
      'tags': tags,
    };
  }
}

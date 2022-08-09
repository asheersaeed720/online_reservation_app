import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  final String restaurantName;
  final String description;
  final String address;
  final String workingHours;
  final List<dynamic> imageUrls;
  final Timestamp createdAt;

  RestaurantModel({
    required this.restaurantName,
    required this.description,
    required this.address,
    required this.workingHours,
    required this.imageUrls,
    required this.createdAt,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      restaurantName: json['restaurant_name'],
      description: json['description'],
      address: json['address'],
      workingHours: json['working_hours'],
      imageUrls: json['image_urls'] ?? [],
      createdAt: json['created_at'],
    );
  }

  Map<String, Object?> toJson() {
    return {
      'restaurant_name': restaurantName,
      'description': description,
      'address': address,
      'working_hours': workingHours,
      'image_urls': imageUrls,
      'created_at': createdAt,
    };
  }
}

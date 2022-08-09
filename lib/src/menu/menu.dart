import 'package:cloud_firestore/cloud_firestore.dart';

enum MenuStatus {
  available,
  unavailable,
}

class MenuModel {
  final String name;
  final String price;
  final String serve;
  final String menuStatus;
  final String category;
  final String restaurantId;
  final String restaurantName;
  final String img;
  final Timestamp createdAt;

  MenuModel({
    required this.name,
    required this.price,
    required this.serve,
    required this.menuStatus,
    required this.category,
    required this.restaurantId,
    required this.restaurantName,
    required this.img,
    required this.createdAt,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      name: json['name'],
      price: json['price'],
      serve: json['serve'],
      menuStatus: json['menu_status'],
      category: json['category'],
      restaurantId: json['restaurant_id'],
      restaurantName: json['restaurant_name'],
      img: json['img'],
      createdAt: json['created_at'],
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'price': price,
      'serve': serve,
      'menu_status': menuStatus,
      'category': category,
      'restaurant_id': restaurantId,
      'restaurant_name': restaurantName,
      'img': img,
      'created_at': createdAt,
    };
  }
}

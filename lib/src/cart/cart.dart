class CartModel {
  final String menuId;
  final String name;
  final int price;
  final String serve;
  final String menuStatus;
  final String category;
  final String restaurantId;
  final String restaurantName;
  final int qty;
  final String img;

  CartModel({
    required this.menuId,
    required this.name,
    required this.price,
    required this.serve,
    required this.menuStatus,
    required this.category,
    required this.restaurantId,
    required this.restaurantName,
    required this.qty,
    required this.img,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      menuId: json['id'],
      name: json['name'],
      price: json['price'],
      serve: json['serve'],
      menuStatus: json['menu_status'],
      category: json['category'],
      restaurantId: json['restaurant_id'],
      restaurantName: json['restaurant_name'],
      qty: json['qty'],
      img: json['img'],
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': menuId,
      'name': name,
      'price': price,
      'serve': serve,
      'menu_status': menuStatus,
      'category': category,
      'restaurant_id': restaurantId,
      'restaurant_name': restaurantName,
      'qty': qty,
      'img': img,
    };
  }
}

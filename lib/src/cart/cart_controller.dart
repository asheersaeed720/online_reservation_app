import 'package:get/get.dart';
import 'package:online_reservation_app/src/cart/cart.dart';

class CartController extends GetxController {
  Map<String, CartModel> cartItemList = {};

  double get totalAmount {
    double total = 0.0;
    cartItemList.forEach((key, cartItem) {
      total += cartItem.price * cartItem.qty;
    });
    return total;
  }

  double get itemPrice {
    double singleItemPrice = 0.0;
    cartItemList.forEach((key, cartItem) {
      singleItemPrice += cartItem.price * 1;
    });
    return singleItemPrice;
  }

  void addToCart({
    required String menuId,
    required String name,
    required int price,
    required String serve,
    required String menuStatus,
    required String category,
    required String restaurantId,
    required String restaurantName,
    required String img,
  }) {
    if (cartItemList.containsKey(menuId)) {
      cartItemList.update(
        menuId,
        (existingCartItem) => CartModel(
          menuId: existingCartItem.menuId,
          name: existingCartItem.name,
          price: existingCartItem.price,
          serve: existingCartItem.serve,
          menuStatus: existingCartItem.menuStatus,
          category: existingCartItem.category,
          restaurantId: existingCartItem.restaurantId,
          restaurantName: existingCartItem.restaurantName,
          qty: existingCartItem.qty + 1,
          img: existingCartItem.img,
        ),
      );
    } else {
      cartItemList.putIfAbsent(
        menuId,
        () => CartModel(
          menuId: menuId,
          name: name,
          price: price,
          serve: serve,
          menuStatus: menuStatus,
          category: category,
          restaurantId: restaurantId,
          restaurantName: restaurantName,
          qty: 1,
          img: img,
        ),
      );
    }
    update();
  }

  void decreaseItem({required String menuId, required int qty}) {
    if (qty == 1) {
      removeMenu(menuId);
    } else if (cartItemList.containsKey(menuId)) {
      cartItemList.update(
        menuId,
        (existingCartItem) => CartModel(
          menuId: existingCartItem.menuId,
          name: existingCartItem.name,
          price: existingCartItem.price,
          serve: existingCartItem.serve,
          menuStatus: existingCartItem.menuStatus,
          category: existingCartItem.category,
          restaurantId: existingCartItem.restaurantId,
          restaurantName: existingCartItem.restaurantName,
          qty: existingCartItem.qty - 1,
          img: existingCartItem.img,
        ),
      );
    }
    update();
  }

  void removeMenu(String id) {
    cartItemList.remove(id);
    if (cartItemList.isEmpty) {
      Get.back();
    }
    update();
  }
}

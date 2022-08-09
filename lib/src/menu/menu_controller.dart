import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_reservation_app/src/menu/menu.dart';
import 'package:online_reservation_app/src/network_manager.dart';
import 'package:online_reservation_app/utils/firebase_collections.dart';

class MenuController extends NetworkManager {
  final menuRef = menuCollection.withConverter<MenuModel>(
    fromFirestore: (snapshot, _) => MenuModel.fromJson(snapshot.data()!),
    toFirestore: (menu, _) => menu.toJson(),
  );

  Stream<QuerySnapshot<MenuModel>> getMenus(String restaurantId) {
    return menuRef
        .where('restaurant_id', isEqualTo: restaurantId)
        .orderBy('created_at', descending: true)
        .snapshots();
  }
}

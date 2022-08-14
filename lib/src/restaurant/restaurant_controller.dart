import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_reservation_app/src/network_manager.dart';
import 'package:online_reservation_app/src/restaurant/restaurant.dart';
import 'package:online_reservation_app/utils/firebase_collections.dart';

class RestaurantController extends NetworkManager {
  final restaurantRef = restaurantCollection.withConverter<RestaurantModel>(
    fromFirestore: (snapshot, _) => RestaurantModel.fromJson(snapshot.data()!),
    toFirestore: (restaurant, _) => restaurant.toJson(),
  );

  Stream<QuerySnapshot<RestaurantModel>> getRestaurants() {
    return restaurantRef.orderBy('created_at', descending: true).snapshots();
  }

  Stream<DocumentSnapshot<RestaurantModel>> getRestaurantsDetails(String restaurantId) {
    return restaurantRef.doc(restaurantId).snapshots();
  }
}

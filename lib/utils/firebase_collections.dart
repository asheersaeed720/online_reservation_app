import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
CollectionReference restaurantCollection = FirebaseFirestore.instance.collection('restaurants');
CollectionReference menuCollection = FirebaseFirestore.instance.collection('menus');
CollectionReference reservationCollection = FirebaseFirestore.instance.collection('reservations');

// final Reference imgStorageRef = FirebaseStorage.instance.ref().child(
//       'uploads/restaurants/${DateTime.now().microsecondsSinceEpoch.remainder(1000000)}',
//     );

import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

// final Reference imgStorageRef = FirebaseStorage.instance.ref().child(
//       'uploads/user/ad_post/${DateTime.now().microsecondsSinceEpoch.remainder(1000000)}',
//     );

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:online_reservation_app/src/network_manager.dart';
import 'package:online_reservation_app/src/reservation/reservation.dart';
import 'package:online_reservation_app/utils/custom_snack_bar.dart';
import 'package:online_reservation_app/utils/firebase_collections.dart';
import 'package:online_reservation_app/widgets/loading_overlay.dart';

class ReservationController extends NetworkManager {
  final reservationRef = reservationCollection.withConverter<ReservationModel>(
    fromFirestore: (snapshot, _) => ReservationModel.fromJson(snapshot.data()!),
    toFirestore: (reservation, _) => reservation.toJson(),
  );

  Stream<QuerySnapshot<ReservationModel>> getReservation() {
    return reservationRef.orderBy('created_at', descending: true).snapshots();
  }

  Future<void> confirmReservation(
    BuildContext context, {
    required String customerName,
    required String numberOfPeople,
    required String phoneNumber,
    required String email,
    required String date,
    required String time,
    required List<Map<String, dynamic>> menuList,
  }) async {
    if (connectionType != 0) {
      loadingOverlay(context);
      await reservationRef.add(
        ReservationModel(
          customerName: customerName,
          numberOfPeople: numberOfPeople,
          phoneNumber: phoneNumber,
          email: email,
          date: date,
          time: time,
          menuList: menuList,
          createdAt: Timestamp.now(),
        ),
      );
      update();
      Loader.hide();
      //! Add navigation soon
    } else {
      customSnackBar('Network error', 'Please try again later');
    }
  }
}

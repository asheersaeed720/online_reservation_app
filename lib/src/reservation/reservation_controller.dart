import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online_reservation_app/src/network_manager.dart';
import 'package:online_reservation_app/src/reservation/reservation.dart';
import 'package:online_reservation_app/src/reservation/views/reservation_congrats_screen.dart';
import 'package:online_reservation_app/utils/custom_snack_bar.dart';
import 'package:online_reservation_app/utils/display_toast_message.dart';
import 'package:online_reservation_app/utils/firebase_collections.dart';
import 'package:online_reservation_app/utils/reservation_status.dart';
import 'package:online_reservation_app/widgets/loading_overlay.dart';

class ReservationController extends NetworkManager {
  Timer? timer;
  List<String> timeSlots = [];
  String selectedTimeSlot = '';
  String timePeriod = '';

  @override
  void onInit() {
    getTimeSlot();
    timer = Timer.periodic(
      const Duration(minutes: 5),
      (Timer t) {
        getTimeSlot();
        DateTime now = DateTime.now();
        timePeriod = DateFormat('hh:mm a').format(now);
      },
    );
    super.onInit();
  }

  void getTimeSlot() {
    DateTime now = DateTime.now();
    DateTime startTime = now.add(const Duration(hours: 1));
    DateTime endTime = DateTime(now.year, now.month, now.day, 23, 0, 0);
    Duration step = const Duration(minutes: 60);

    timeSlots = [];

    while (startTime.isBefore(endTime)) {
      DateTime timeIncrement = startTime.add(step);
      timeSlots.add(DateFormat.Hm().format(timeIncrement));
      startTime = timeIncrement;
    }
    update();
    log('$timeSlots');
  }

  void selectTimeSlot(bool selected, String slot) {
    selectedTimeSlot = selected ? slot : '';
    update();
  }

  final reservationRef = reservationCollection.withConverter<ReservationModel>(
    fromFirestore: (snapshot, _) => ReservationModel.fromJson(snapshot.data()!),
    toFirestore: (reservation, _) => reservation.toJson(),
  );

  Stream<QuerySnapshot<ReservationModel>> getReservation() {
    return reservationRef.orderBy('created_at', descending: true).snapshots();
  }

  Stream<DocumentSnapshot<ReservationModel>> getUserReservationDetails(String reservationId) {
    return reservationRef.doc(reservationId).snapshots();
  }

  Future<void> confirmReservation(
    BuildContext context, {
    required String customerName,
    required String numberOfPeople,
    required String phoneNumber,
    required String email,
    required String date,
    required String restaurantId,
    required List<Map<String, dynamic>> menuList,
    required double totalAmount,
  }) async {
    if (connectionType != 0) {
      loadingOverlay(context);
      //! also add status & total amount
      await reservationRef.add(
        ReservationModel(
          customerName: customerName,
          numberOfPeople: numberOfPeople,
          phoneNumber: phoneNumber,
          email: email,
          date: date,
          time: selectedTimeSlot,
          restaurantId: restaurantId,
          menuList: menuList,
          totalAmount: totalAmount,
          createdAt: Timestamp.now(),
        ),
      );
      update();
      Loader.hide();
      log('reservationRef ${reservationRef.doc().id}');
      Get.offAllNamed(ReservationCongratsScreen.routeName, arguments: reservationRef.doc().id);
    } else {
      customSnackBar('Network error', 'Please try again later');
    }
  }

  Future<void> cancelReservation(String reservationId) async {
    if (connectionType != 0) {
      await reservationRef.doc(reservationId).update({
        'status': ReservationStatus.cancel,
      });
    } else {
      displayToastMessage('Network error, please try again later');
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/reservation/reservation.dart';
import 'package:online_reservation_app/src/reservation/reservation_controller.dart';
import 'package:online_reservation_app/widgets/loading_widget.dart';

class ReservationDetailScreen extends StatelessWidget {
  static const String routeName = '/reservation-detail';

  ReservationDetailScreen({Key? key}) : super(key: key);

  final _reservationCtrl = Get.put(ReservationController());

  @override
  Widget build(BuildContext context) {
    final String reservationId = Get.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation Detail'),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: StreamBuilder<DocumentSnapshot<ReservationModel>>(
        stream: _reservationCtrl.getUserReservationDetails(reservationId),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot<ReservationModel> reservationDetail =
                snapshot.data as DocumentSnapshot<ReservationModel>;
            return Text(reservationDetail.data()!.customerName);
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:online_reservation_app/src/reservation/reservation.dart';
import 'package:online_reservation_app/src/reservation/reservation_controller.dart';
import 'package:online_reservation_app/src/reservation/views/reservation_detail_screen.dart';
import 'package:online_reservation_app/utils/constants.dart';
import 'package:online_reservation_app/utils/reservation_status.dart';
import 'package:online_reservation_app/widgets/loading_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserReservationScreen extends StatelessWidget {
  static const String routeName = '/user-reservations';

  UserReservationScreen({Key? key}) : super(key: key);

  final _reservationCtrl = Get.put(ReservationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('reservation'.tr),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: StreamBuilder<QuerySnapshot<ReservationModel>>(
        stream: _reservationCtrl.getReservation(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot<ReservationModel>> reservationList =
                snapshot.data!.docs as List<QueryDocumentSnapshot<ReservationModel>>;
            return ListView.separated(
              padding: const EdgeInsets.all(10.0),
              itemCount: reservationList.length,
              separatorBuilder: (context, _) => const SizedBox(height: 10.0),
              itemBuilder: (context, i) {
                return _buildReservationItemView(
                    context, reservationList[i].id, reservationList[i].data());
              },
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Widget _buildReservationItemView(
      BuildContext context, String reservationId, ReservationModel reservationItem) {
    final String postedDate = timeago.format(reservationItem.createdAt.toDate());

    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: InkWell(
          onTap: () {
            Get.toNamed(ReservationDetailScreen.routeName, arguments: reservationId);
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0, left: 12.0, top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(postedDate),
                    if (reservationItem.status == ReservationStatus.completed)
                      Text(
                        reservationItem.status,
                        style: kBodyStyle.copyWith(color: Colors.green),
                      ),
                    if (reservationItem.status == ReservationStatus.pending)
                      Text(
                        reservationItem.status,
                        style: kBodyStyle.copyWith(color: Colors.blue),
                      ),
                    if (reservationItem.status == ReservationStatus.cancel)
                      Text(
                        reservationItem.status,
                        style: kBodyStyle.copyWith(color: Colors.red.shade700),
                      ),
                  ],
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                horizontalTitleGap: 10.0,
                leading: CircleAvatar(
                  backgroundColor: Colors.orange.shade300,
                  child: Text(
                    '${reservationItem.customerName[0].capitalizeFirst}',
                    style: kBodyStyle.copyWith(color: kPrimaryColor, fontSize: 20.0),
                  ),
                ),
                title: Text(reservationItem.customerName, style: kBodyStyle),
                subtitle: Text(reservationItem.phoneNumber),
                trailing: Text(
                  'Amount: ${reservationItem.totalAmount}',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0, left: 12.0, bottom: 10.0),
                child: Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.grey.shade600),
                    const SizedBox(width: 8.0),
                    Text(
                      '${reservationItem.time}\n${reservationItem.date}',
                      style: const TextStyle(fontSize: 12.0),
                    ),
                    const Spacer(),
                    Icon(Icons.people, color: Colors.grey.shade600),
                    const SizedBox(width: 8.0),
                    Text(reservationItem.numberOfPeople),
                    const Spacer(),
                    const Text('View'),
                    const SizedBox(width: 8.0),
                    Icon(Icons.arrow_forward, color: Colors.grey.shade600),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

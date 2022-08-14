import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/reservation/reservation.dart';
import 'package:online_reservation_app/src/reservation/reservation_controller.dart';
import 'package:online_reservation_app/src/restaurant/restaurant.dart';
import 'package:online_reservation_app/src/restaurant/restaurant_controller.dart';
import 'package:online_reservation_app/utils/constants.dart';
import 'package:online_reservation_app/utils/custom_dialog.dart';
import 'package:online_reservation_app/utils/reservation_status.dart';
import 'package:online_reservation_app/widgets/custom_async_btn.dart';
import 'package:online_reservation_app/widgets/loading_widget.dart';

class ReservationDetailScreen extends StatelessWidget {
  static const String routeName = '/reservation-detail';

  ReservationDetailScreen({Key? key}) : super(key: key);

  final _reservationCtrl = Get.put(ReservationController());
  final _restaurantCtrl = Get.put(RestaurantController());

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
            log('${reservationDetail.data()?.menuList}');
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              children: [
                const SizedBox(height: 10.0),
                Text('Your Details', style: kBodyStyle),
                const SizedBox(height: 6.0),
                _buildCustomerDetailsView(reservationDetail),
                const SizedBox(height: 10.0),
                const Divider(thickness: 1.0),
                const SizedBox(height: 8.0),
                Text('Reservation Details', style: kBodyStyle),
                const SizedBox(height: 6.0),
                _buildReservationDetailsView(reservationDetail),
                const SizedBox(height: 10.0),
                const Divider(thickness: 1.0),
                const SizedBox(height: 8.0),
                Text('Menu Details', style: kBodyStyle),
                const SizedBox(height: 6.0),
                _buildMenuDetailsView(reservationDetail),
                const SizedBox(height: 6.0),
                if (reservationDetail.data()?.status == ReservationStatus.pending)
                  CustomAsyncBtn(
                    btnColor: Colors.red.shade700,
                    btnTxt: 'Cancel',
                    onPress: () {
                      customAlertDialog(
                        context,
                        'Cancel Reservation',
                        'Are you sure?',
                        () async {
                          await _reservationCtrl.cancelReservation(reservationId);
                        },
                      );
                    },
                  ),
                const SizedBox(height: 10.0),
              ],
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Widget _buildReservationDetailsView(DocumentSnapshot<ReservationModel> reservationDetail) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Reservation No #: ',
                style: kBodyStyle.copyWith(fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(
                    text: reservationDetail.id,
                    style: kBodyStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            RichText(
              text: TextSpan(
                text: 'Date: ',
                style: kBodyStyle.copyWith(fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(
                    text: reservationDetail.data()?.date,
                    style: kBodyStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            RichText(
              text: TextSpan(
                text: 'Time: ',
                style: kBodyStyle.copyWith(fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(
                    text: reservationDetail.data()?.time,
                    style: kBodyStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            RichText(
              text: TextSpan(
                text: 'Number of people: ',
                style: kBodyStyle.copyWith(fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(
                    text: reservationDetail.data()?.numberOfPeople,
                    style: kBodyStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            RichText(
              text: TextSpan(
                text: 'Status: ',
                style: kBodyStyle.copyWith(fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  if (reservationDetail.data()?.status == ReservationStatus.completed)
                    TextSpan(
                      text: reservationDetail.data()?.status,
                      style: kBodyStyle.copyWith(color: Colors.green),
                    ),
                  if (reservationDetail.data()?.status == ReservationStatus.pending)
                    TextSpan(
                      text: reservationDetail.data()?.status,
                      style: kBodyStyle.copyWith(color: Colors.blue),
                    ),
                  if (reservationDetail.data()?.status == ReservationStatus.cancel)
                    TextSpan(
                      text: reservationDetail.data()?.status,
                      style: kBodyStyle.copyWith(color: Colors.red.shade700),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            RichText(
              text: TextSpan(
                text: 'Amount: ',
                style: kBodyStyle.copyWith(fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(
                    text: '\$${reservationDetail.data()?.totalAmount}',
                    style: kBodyStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            _buildRestaurantDetailsView(reservationDetail.data()?.restaurantId ?? ''),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerDetailsView(DocumentSnapshot<ReservationModel> reservationDetail) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Name: ',
                style: kBodyStyle.copyWith(fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(
                    text: reservationDetail.data()?.customerName.capitalizeFirst,
                    style: kBodyStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            RichText(
              text: TextSpan(
                text: 'Phone No: ',
                style: kBodyStyle.copyWith(fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(
                    text: reservationDetail.data()?.phoneNumber,
                    style: kBodyStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            RichText(
              text: TextSpan(
                text: 'Email: ',
                style: kBodyStyle.copyWith(fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(
                    text: reservationDetail.data()?.email,
                    style: kBodyStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantDetailsView(String restaurantId) {
    return StreamBuilder<DocumentSnapshot<RestaurantModel>>(
      stream: _restaurantCtrl.getRestaurantsDetails(restaurantId),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasError) {
          DocumentSnapshot<RestaurantModel> restaurantDetails =
              snapshot.data as DocumentSnapshot<RestaurantModel>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Restaurant Name: ',
                  style: kBodyStyle.copyWith(fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                    TextSpan(
                      text: restaurantDetails.data()?.restaurantName.capitalizeFirst,
                      style: kBodyStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4.0),
              RichText(
                text: TextSpan(
                  text: 'Address: ',
                  style: kBodyStyle.copyWith(fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                    TextSpan(
                      text: restaurantDetails.data()?.address,
                      style: kBodyStyle,
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return const LoadingWidget();
      },
    );
  }

  Widget _buildMenuDetailsView(DocumentSnapshot<ReservationModel> reservationDetail) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...(reservationDetail.data()?.menuList)!.map(
              (e) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Menu Name: ',
                      style: kBodyStyle.copyWith(fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${e['menuName']}',
                          style: kBodyStyle,
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Quantity: ',
                      style: kBodyStyle.copyWith(fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'x ${e['qty']}',
                          style: kBodyStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/tab_screen.dart';
import 'package:online_reservation_app/utils/constants.dart';

class ReservationCongratsScreen extends StatelessWidget {
  static const String routeName = '/reservation-congrats';

  const ReservationCongratsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String reservationId = Get.arguments as String;

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/reservation.png', width: 138.0),
            const SizedBox(height: 18.0),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Congratulations,',
                style: kTitleStyle.copyWith(color: Colors.green, fontWeight: FontWeight.w900),
                children: <TextSpan>[
                  TextSpan(
                    text: ' your reservation has been successfully sent...',
                    style: kTitleStyle.copyWith(color: Colors.green),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 18.0),
            // CustomAsyncBtn(
            //   width: MediaQuery.of(context).size.width * 0.8,
            //   height: 42.0,
            //   btnTxt: 'View Details',
            //   onPress: () async {
            //     final tabScreenCtrl = Get.put(TabScreenController());
            //     Get.offAndToNamed(TabScreen.routeName);
            //     tabScreenCtrl.onItemTapped(1);
            //     await Future.delayed(const Duration(milliseconds: 800));
            //     Get.toNamed(ReservationDetailScreen.routeName, arguments: reservationId);
            //   },
            // ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 42.0,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.arrow_back, color: kPrimaryColor),
                label: Text('Go back', style: kBodyStyle.copyWith(color: kPrimaryColor)),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  elevation: MaterialStateProperty.all(0.0),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      side: const BorderSide(color: kPrimaryColor, width: 1.5),
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                  ),
                ),
                onPressed: () {
                  Get.offAndToNamed(TabScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

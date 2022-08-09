import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/account/user_account_screen.dart';
import 'package:online_reservation_app/src/reservation/user_reservation_screen.dart';
import 'package:online_reservation_app/src/restaurant/views/restaurant_screen.dart';
import 'package:online_reservation_app/utils/constants.dart';

class TabScreen extends StatelessWidget {
  static const String routeName = '/tab';

  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      RestaurantScreen(),
      const UserReservationScreen(),
      const UserAccountScreen(),
    ];

    return DefaultTabController(
      length: 5,
      child: GetBuilder<TabScreenController>(
        init: TabScreenController(),
        builder: (tabController) => Scaffold(
          body: widgetOptions.elementAt(tabController.selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: 'restaurant'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.date_range_rounded),
                label: 'reservation'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.account_circle),
                label: 'account'.tr,
              ),
            ],
            currentIndex: tabController.selectedIndex,
            selectedItemColor: kPrimaryColor,
            onTap: tabController.onItemTapped,
          ),
        ),
      ),
    );
  }
}

class TabScreenController extends GetxController {
  int selectedIndex = 0;

  onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
}

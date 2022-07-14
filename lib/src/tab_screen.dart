import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/account/user_account_screen.dart';
import 'package:online_reservation_app/src/home/home_screen.dart';
import 'package:online_reservation_app/src/reservation/user_reservation_screen.dart';
import 'package:online_reservation_app/utils/constants.dart';

class TabScreen extends StatelessWidget {
  static const String routeName = '/tab';

  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      const HomeScreen(),
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
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.date_range_rounded),
                label: 'Reservations',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
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

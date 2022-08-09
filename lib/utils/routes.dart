import 'package:get/get.dart';
import 'package:online_reservation_app/src/account/edit_account_screen.dart';
import 'package:online_reservation_app/src/auth/views/login_screen.dart';
import 'package:online_reservation_app/src/auth/views/signup_screen.dart';
import 'package:online_reservation_app/src/menu_screen/views/menu_screen.dart';
import 'package:online_reservation_app/src/restaurant/views/restaurant_detail_screen.dart';
import 'package:online_reservation_app/src/search/views/search_screen.dart';
import 'package:online_reservation_app/src/tab_screen.dart';

final List<GetPage<dynamic>> routes = [
  GetPage(
    name: LogInScreen.routeName,
    page: () => const LogInScreen(),
  ),
  GetPage(
    name: SignUpScreen.routeName,
    page: () => const SignUpScreen(),
  ),
  GetPage(
    name: TabScreen.routeName,
    page: () => const TabScreen(),
  ),
  GetPage(
    name: SearchScreen.routeName,
    page: () => SearchScreen(),
  ),
  GetPage(
    name: EditAccountScreen.routeName,
    page: () => const EditAccountScreen(),
  ),
  GetPage(
    name: RestaurantDetailScreen.routeName,
    page: () => const RestaurantDetailScreen(),
  ),
  GetPage(
    name: MenuScreen.routeName,
    page: () => MenuScreen(),
  ),
];

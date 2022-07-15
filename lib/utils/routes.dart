import 'package:get/get.dart';
import 'package:online_reservation_app/src/account/edit_account_screen.dart';
import 'package:online_reservation_app/src/auth/views/login_screen.dart';
import 'package:online_reservation_app/src/auth/views/signup_screen.dart';
import 'package:online_reservation_app/src/search/views/search_screen.dart';
import 'package:online_reservation_app/src/store_detail_screen.dart';
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
    name: StoreDetailScreen.routeName,
    page: () => const StoreDetailScreen(),
  ),
  GetPage(
    name: SearchScreen.routeName,
    page: () => SearchScreen(),
  ),
  GetPage(
    name: EditAccountScreen.routeName,
    page: () => const EditAccountScreen(),
  ),
];

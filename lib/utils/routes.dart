import 'package:get/get.dart';
import 'package:online_reservation_app/src/auth/views/login_screen.dart';
import 'package:online_reservation_app/src/auth/views/signup_screen.dart';
import 'package:online_reservation_app/src/home/home_screen.dart';

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
    name: HomeScreen.routeName,
    page: () => const HomeScreen(),
  ),
];

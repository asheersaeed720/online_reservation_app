import 'package:get/get.dart';
import 'package:online_reservation_app/src/auth/auth_controller.dart';
import 'package:online_reservation_app/src/auth/auth_service.dart';
import 'package:online_reservation_app/src/localization/language_controller.dart';
import 'package:online_reservation_app/src/network_manager.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager(), permanent: true);
    Get.put(LanguageController(), permanent: true);
    Get.put(AuthService(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }
}

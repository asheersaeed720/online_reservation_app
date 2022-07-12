import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_reservation_app/src/auth/auth_service.dart';
import 'package:online_reservation_app/src/network_manager.dart';
import 'package:online_reservation_app/utils/custom_snack_bar.dart';
import 'package:online_reservation_app/utils/display_toast_message.dart';

class AuthController extends NetworkManager {
  final _authService = Get.find<AuthService>();

  final GetStorage _getStorage = GetStorage();

  Map currentUserData = {};

  bool isLoading = false;

  bool obscureText = true;

  String rememberEmail = '';

  @override
  void onInit() {
    log('${FirebaseAuth.instance.currentUser}', name: 'Firebase User');
    currentUserData = getCurrentUser();
    rememberEmail = _getStorage.read('email') ?? '';
    super.onInit();
  }

  void togglePw() {
    obscureText = !obscureText;
    update();
  }

  Future<bool> handleSignUp({
    required String fname,
    required String lname,
    required String email,
    required String password,
  }) async {
    if (connectionType != 0) {
      return ((await _authService.signUpUser(fname, lname, email, password)) != null);
    } else {
      customSnackBar('Network error', 'Please try again later');
      return false;
    }
  }

  Future<bool> handleLogIn({
    required String email,
    required String password,
  }) async {
    if (connectionType != 0) {
      return ((await _authService.logInUser(email, password)) != null);
    } else {
      customSnackBar('Network error', 'Please try again later');
      return false;
    }
  }

  Future<bool> handleUpdatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (connectionType != 0) {
      return ((await _authService.updatePassword(currentPassword, newPassword)) != null);
    } else {
      customSnackBar('Network error', 'Please try again later');
      return false;
    }
  }

  Map getCurrentUser() {
    Map userData = _getStorage.read('user') ?? {};
    if (userData.isNotEmpty) {
      Map user = userData;
      log('$userData', name: 'storeUser');
      return user;
    } else {
      return {};
    }
  }

  logoutUser() async {
    await FirebaseAuth.instance.signOut();
    _getStorage.remove('user');
    currentUserData = _getStorage.read('user') ?? {};
    update();
    displayToastMessage('Logout');
    // Get.offAllNamed(AuthProvidersScreen.routeName);
  }
}

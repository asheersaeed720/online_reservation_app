import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_reservation_app/src/auth/auth_service.dart';
import 'package:online_reservation_app/src/auth/views/otp_verification_screen.dart';
import 'package:online_reservation_app/src/auth/views/signup_screen.dart';
import 'package:online_reservation_app/src/home/home_screen.dart';
import 'package:online_reservation_app/src/network_manager.dart';
import 'package:online_reservation_app/utils/custom_snack_bar.dart';
import 'package:online_reservation_app/utils/display_toast_message.dart';
import 'package:online_reservation_app/utils/firebase_collections.dart';

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
    usersCollection.get().then((doc) {
      for (var element in doc.docs) {
        log('id ${element.id}');
        log('${element.data()}');
        log('${element.get('mobile_no')}');
      }
    });
    super.onInit();
  }

  void togglePw() {
    obscureText = !obscureText;
    update();
  }

  Future<bool> handleSignUp({
    required String fname,
    required String email,
    required String mobileNo,
    required UserGender gender,
    required String password,
  }) async {
    if (connectionType != 0) {
      return ((await _authService.signUpUser(fname, email, mobileNo, gender, password)) != null);
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

  Future<void> sendOtp(String mobileNo) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: mobileNo,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          displayToastMessage('The provided phone number is not valid.');
        } else {
          displayToastMessage('${e.message}');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        Get.to(
          () => OtpVerificationScreen(
            phoneNumber: mobileNo,
            verificationId: verificationId,
          ),
        );
      },
      timeout: const Duration(seconds: 120),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifyMobileNo({
    required String verificationId,
    required String smsCode,
    required String mobileNo,
  }) async {
    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      log('verification completed: $value');
      usersCollection.get().then((doc) {
        for (var element in doc.docs) {
          if (element.get('mobile_no') == mobileNo) {
            Get.offAllNamed(HomeScreen.routeName);
          } else {
            Get.toNamed(
              SignUpScreen.routeName,
              arguments: {'mobileNo': mobileNo},
            );
          }
        }
      });
    }).catchError((e) {
      displayToastMessage('Invalid Code');
    });
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

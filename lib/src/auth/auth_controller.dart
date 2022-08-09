import 'dart:developer';

import 'package:encrypt/encrypt.dart' as EncryptPack;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_reservation_app/src/auth/auth_service.dart';
import 'package:online_reservation_app/src/auth/views/login_screen.dart';
import 'package:online_reservation_app/src/auth/views/otp_verification_screen.dart';
import 'package:online_reservation_app/src/auth/views/signup_screen.dart';
import 'package:online_reservation_app/src/network_manager.dart';
import 'package:online_reservation_app/src/tab_screen.dart';
import 'package:online_reservation_app/utils/custom_snack_bar.dart';
import 'package:online_reservation_app/utils/display_toast_message.dart';
import 'package:online_reservation_app/utils/firebase_collections.dart';
import 'package:online_reservation_app/widgets/loading_overlay.dart';

class AuthController extends NetworkManager {
  final _authService = Get.find<AuthService>();

  final GetStorage _getStorage = GetStorage();

  Map currentUserData = {};

  bool isLoading = false;

  bool obscureText = true;

  @override
  void onInit() {
    log('${FirebaseAuth.instance.currentUser}', name: 'Firebase User');
    // currentUserData = getCurrentUser();
    // passwordEncrypt('noob');
    // passwordDecrypt('AEaVZ5E7DC/JpXPl1SYoBn20ydjEZ+d/XneYZaX4eFk=');
    super.onInit();
  }

  Future<void> sendOtp(BuildContext context, String mobileNo) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    loadingOverlay(context);

    await auth.verifyPhoneNumber(
      phoneNumber: mobileNo,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          displayToastMessage('The provided phone number is not valid.');
        } else {
          displayToastMessage('${e.message}');
        }
        Loader.hide();
      },
      codeSent: (String verificationId, int? resendToken) async {
        Loader.hide();
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

  Future<void> verifyMobileNo(
    BuildContext context, {
    required String verificationId,
    required String smsCode,
    required String mobileNo,
  }) async {
    loadingOverlay(context);

    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((res) async {
      log('verification completed: $res');

      userCollection.doc('${res.user?.uid}').get().then(
        (documentSnapshot) async {
          log('documentSnapshot ${documentSnapshot.data()}');
          if (documentSnapshot.data() == null) {
            Loader.hide();
            Get.toNamed(
              SignUpScreen.routeName,
              arguments: {
                'mobileNo': mobileNo,
                'user': res.user,
              },
            );
          } else {
            await handleLogIn(
              fullname: documentSnapshot.get('full_name'),
              email: documentSnapshot.get('email'),
              password: documentSnapshot.get('password'),
            ).catchError((_) {
              Loader.hide();
            });
            Loader.hide();
          }
        },
      );
    }).catchError((e) {
      Loader.hide();
      displayToastMessage('Invalid Code');
    });
  }

  Future<bool> handleSignUp({
    required User user,
    required String fname,
    required String email,
    required String mobileNo,
    required UserGender gender,
    required String password,
  }) async {
    if (connectionType != 0) {
      String encryptedPw = passwordEncrypt(password);
      bool isAuth =
          ((await _authService.signUpUser(user, fname, email, mobileNo, gender, encryptedPw)) !=
              null);
      if (isAuth) {
        Get.offAllNamed(TabScreen.routeName);
      }
      return isAuth;
    } else {
      customSnackBar('Network error', 'Please try again later');
      return false;
    }
  }

  Future<bool> handleLogIn({
    required String fullname,
    required String email,
    required String password,
  }) async {
    if (connectionType != 0) {
      bool isAuth = ((await _authService.logInUser(fullname, email, password)) != null);
      if (isAuth) {
        Get.offAllNamed(TabScreen.routeName);
      }
      return isAuth;
    } else {
      customSnackBar('Network error', 'Please try again later');
      return false;
    }
  }

  String passwordEncrypt(String password) {
    final jsonString = '{"password": $password}';
    final key = EncryptPack.Key.fromUtf8('Shhs2xQ5gT76JcFps908U0AqI8mKWfoH');
    final iv = EncryptPack.IV.fromUtf8('hwldowdrldhewlaw');
    final encrypter = EncryptPack.Encrypter(EncryptPack.AES(key, mode: EncryptPack.AESMode.cbc));
    final encrypted = encrypter.encrypt(jsonString, iv: iv);
    // final decrypted = encrypter.decrypt(encrypted, iv: iv);
    log('encrypted ${encrypted.base64}');
    return encrypted.base64;
  }

  // Future<bool> handleUpdatePassword({
  //   required String currentPassword,
  //   required String newPassword,
  // }) async {
  //   if (connectionType != 0) {
  //     return ((await _authService.updatePassword(currentPassword, newPassword)) != null);
  //   } else {
  //     customSnackBar('Network error', 'Please try again later');
  //     return false;
  //   }
  // }

  // Map getCurrentUser() {
  //   Map userData = _getStorage.read('user') ?? {};
  //   if (userData.isNotEmpty) {
  //     Map user = userData;
  //     log('$userData', name: 'storeUser');
  //     return user;
  //   } else {
  //     return {};
  //   }
  // }

  logoutUser() async {
    await FirebaseAuth.instance.signOut();
    _getStorage.remove('user');
    currentUserData = _getStorage.read('user') ?? {};
    update();
    displayToastMessage('Logout');
    Get.offAllNamed(LogInScreen.routeName);
  }
}

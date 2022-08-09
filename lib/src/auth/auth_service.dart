import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/auth/views/signup_screen.dart';
import 'package:online_reservation_app/utils/display_toast_message.dart';
import 'package:online_reservation_app/utils/firebase_collections.dart';

class AuthService extends GetConnect {
  Future<UserCredential?> signUpUser(
    User user,
    String fullName,
    String email,
    String mobileNo,
    UserGender gender,
    String password,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Map<String, dynamic> data = {
        "uid": user.uid,
        "full_name": fullName,
        "email": email,
        "mobile_no": mobileNo,
        "gender": gender.name,
        "password": password,
      };
      if (userCredential.user != null) {
        await userCollection.doc(user.uid).set(data);
        userCredential.user?.updateDisplayName(fullName);
        userCredential.user?.updateEmail(email);
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        displayToastMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        displayToastMessage('The account already exists for that email.');
      }
    } catch (e) {
      log('$e');
    }
    return null;
  }

  Future<UserCredential?> logInUser(String fullName, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        userCredential.user?.updateDisplayName(fullName);
        userCredential.user?.updateEmail(email);
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        displayToastMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        displayToastMessage('Wrong password provided for that user.');
      }
    }
    return null;
  }

  // resentVerificationCode(userFormDataFrom) async {
  //   isLoading.value = true;
  //   await _firebaseAuth.verifyPhoneNumber(
  //     phoneNumber: '${userModel.value.mobileNo}',
  //     verificationCompleted: (PhoneAuthCredential credential) async {},
  //     verificationFailed: (FirebaseAuthException e) {
  //       if (e.code == 'invalid-phone-number') {
  //         displayToastMessage('The provided phone number is not valid.');
  //       }
  //     },
  //     codeSent: (String verificationId, int? resendToken) async {
  //       isLoading.value = false;
  //     },
  //     timeout: const Duration(seconds: 60),
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       isLoading.value = false;
  //     },
  //   );
  // }

  Future<UserCredential?> updatePassword(String currentPassword, String newPassword) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final emailProviderCred = EmailAuthProvider.credential(
        email: user?.email ?? '',
        password: currentPassword,
      );
      UserCredential userCredential = await user!.reauthenticateWithCredential(emailProviderCred);
      userCredential.user?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      log('$e');
    }
    return null;
  }
}

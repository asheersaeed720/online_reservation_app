import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/account/edit_account_screen.dart';
import 'package:online_reservation_app/src/auth/auth_controller.dart';
import 'package:online_reservation_app/src/localization/language_controller.dart';
import 'package:online_reservation_app/utils/constants.dart';

class UserAccountScreen extends StatelessWidget {
  static const String routeName = '/user-account';

  const UserAccountScreen({Key? key}) : super(key: key);

  // final Color kSecondaryColor = const Color(0xFF253241);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('account'.tr),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            _buildLessProfileInfoView(context),
            const SizedBox(height: 12.0),
            _buildRateUsView(),
            const SizedBox(height: 12.0),
            // _buildNotificationView(),
            _buildLanguageView(),
            const SizedBox(height: 12.0),
            _buildPrivacyView(),
            const SizedBox(height: 12.0),
            _buildTermsView(),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(bottom: 36.0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 42.0,
              child: ElevatedButton(
                onPressed: () => Get.find<AuthController>().logoutUser(),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      side: const BorderSide(width: 1.0, color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'logout'.tr,
                      style: kBodyStyle.copyWith(color: kPrimaryColor),
                    ),
                    const SizedBox(width: 8.0),
                    const Icon(Icons.exit_to_app, color: kPrimaryColor)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLessProfileInfoView(BuildContext context) {
    User? authUser = FirebaseAuth.instance.currentUser;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kPrimaryColor.withOpacity(0.9),
            kPrimaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        onTap: () {
          Get.toNamed(EditAccountScreen.routeName);
        },
        leading: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(
            Icons.person,
            color: kPrimaryColor,
          ),
        ),
        title: Text(
          authUser?.displayName?.capitalizeFirst ?? '',
          style: kBodyStyle.copyWith(color: Colors.white),
        ),
        subtitle: Text(
          authUser?.email ?? '',
          style: const TextStyle(color: Colors.white),
        ),
        trailing: const InkWell(
          // onTap: () => Get.toNamed(EditProfileScreen.routeName),
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 24.0,
          ),
        ),
      ),
    );
  }

  Widget _buildRateUsView() {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.green.shade100,
        ),
        child: const Icon(Icons.rate_review, color: Colors.green),
      ),
      title: Text(
        'rate_us'.tr,
        style: kBodyStyle,
      ),
    );
  }

  // Widget _buildNotificationView() {
  //   return ListTile(
  //     leading: Container(
  //       padding: const EdgeInsets.all(8.0),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(6.0),
  //         color: Colors.blue.shade100,
  //       ),
  //       child: const Icon(Icons.notifications, color: Colors.blue),
  //     ),
  //     title: Text(
  //       'Notification',
  //       style: kBodyStyle,
  //     ),
  //     trailing: Switch(
  //       value: true,
  //       onChanged: (value) {},
  //       activeTrackColor: kSecondaryColor.withOpacity(0.8),
  //       activeColor: kSecondaryColor,
  //     ),
  //   );
  // }

  Widget _buildLanguageView() {
    return ListTile(
      onTap: () async {
        // await launch('https://achadvertising.com/privacy-policy/');
      },
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.blueGrey.shade100,
        ),
        child: const Icon(Icons.language, color: Colors.blueGrey),
      ),
      title: Text(
        'language'.tr,
        style: kBodyStyle,
      ),
      trailing: GetBuilder<LanguageController>(
        builder: (langController) => ToggleButtons(
          constraints: const BoxConstraints(
            minHeight: 38.0,
            minWidth: 48.0,
          ),
          borderRadius: BorderRadius.circular(kBorderRadius),
          onPressed: (int index) {
            if (index == 0) {
              langController.toggleLanguage[index] = true;
              langController.toggleLanguage[1] = false;
              langController.changeLanguage(
                language: 'English',
                languageCode: 'en',
                countryCode: 'US',
              );
            } else if (index == 1) {
              langController.toggleLanguage[index] = true;
              langController.toggleLanguage[0] = false;
              langController.changeLanguage(
                language: 'Arabic',
                languageCode: 'ar',
                countryCode: 'SA',
              );
            }
            langController.update();
          },
          isSelected: langController.toggleLanguage,
          children: const <Widget>[
            Text('Eng'),
            Text('Ar'),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyView() {
    return ListTile(
      onTap: () async {
        // await launch('https://achadvertising.com/privacy-policy/');
      },
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.orange.shade100,
        ),
        child: const Icon(Icons.privacy_tip, color: Colors.orange),
      ),
      title: Text(
        'privacy_policy'.tr,
        style: kBodyStyle,
      ),
    );
  }

  Widget _buildTermsView() {
    return ListTile(
      onTap: () async {
        // await launch('https://achadvertising.com/terms-and-conditions/');
      },
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.purple.shade100,
        ),
        child: const Icon(Icons.note, color: Colors.purple),
      ),
      title: Text(
        'terms&conditions'.tr,
        style: kBodyStyle,
      ),
    );
  }
}

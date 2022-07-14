import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/auth/auth_controller.dart';
import 'package:online_reservation_app/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class UserAccountScreen extends StatelessWidget {
  static const String routeName = '/user-account';

  const UserAccountScreen({Key? key}) : super(key: key);

  final Color kSecondaryColor = const Color(0xFF253241);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
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
            _buildNotificationView(),
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
                      'Logout',
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
            kSecondaryColor.withOpacity(0.9),
            kSecondaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(
            Icons.person,
            color: kSecondaryColor,
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

  Widget _buildNotificationView() {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.blue.shade100,
        ),
        child: const Icon(Icons.notifications, color: Colors.blue),
      ),
      title: Text(
        'Notification',
        style: kBodyStyle,
      ),
      trailing: Switch(
        value: true,
        onChanged: (value) {},
        activeTrackColor: kSecondaryColor.withOpacity(0.8),
        activeColor: kSecondaryColor,
      ),
    );
  }

  Widget _buildPrivacyView() {
    return ListTile(
      onTap: () async {
        await launch('https://achadvertising.com/privacy-policy/');
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
        'Privacy Policy',
        style: kBodyStyle,
      ),
    );
  }

  Widget _buildTermsView() {
    return ListTile(
      // onTap: () => Get.toNamed(WebViewScreen.routeName, arguments: {
      //   'title': 'Terms & Conditions',
      //   'url': 'https://achadvertising.com/terms-and-conditions/',
      // }),
      onTap: () async {
        await launch('https://achadvertising.com/terms-and-conditions/');
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
        'Terms & Conditions',
        style: kBodyStyle,
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
        'Rate Us',
        style: kBodyStyle,
      ),
    );
  }
}

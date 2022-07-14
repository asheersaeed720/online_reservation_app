import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/auth/auth_controller.dart';
import 'package:online_reservation_app/src/localization/language_controller.dart';
import 'package:online_reservation_app/utils/constants.dart';
import 'package:online_reservation_app/widgets/custom_async_btn.dart';
import 'package:online_reservation_app/widgets/custom_input_field.dart';

class LogInScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _authController = Get.find<AuthController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _mobileNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 38.0,
            right: 20.0,
            child: GetBuilder<LanguageController>(
              builder: (langController) => ToggleButtons(
                borderRadius: BorderRadius.circular(kBorderRadius),
                onPressed: (int index) {
                  log('index $index');
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
          ),
          GetBuilder<AuthController>(
            builder: (_) => Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 5.2,
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        padding: const EdgeInsets.all(25),
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Center(
                        child: Text(
                          'Login/Registration',
                          style: kTitleStyle,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        padding: const EdgeInsets.only(left: 30, right: 20),
                        child: const Text(
                          'Enter your mobile',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      CustomInputField(
                        hintText: 'Mobile No',
                        controller: _mobileNoController,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 16),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
                        child: CustomAsyncBtn(
                          btnTxt: 'continue'.tr,
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              FocusScopeNode currentFocus = FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              await _authController.sendOtp(context, _mobileNoController.text);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

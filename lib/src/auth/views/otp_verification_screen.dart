import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/auth/auth_controller.dart';
import 'package:online_reservation_app/widgets/custom_async_btn.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class OtpVerificationScreen extends StatefulWidget {
  static const String routeName = '/otp';

  final String phoneNumber;
  final String verificationId;

  const OtpVerificationScreen({
    Key? key,
    required this.phoneNumber,
    required this.verificationId,
  }) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  TextEditingController textEditingController = TextEditingController();

  // StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final _formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   errorController = StreamController<ErrorAnimationType>();
  //   super.initState();
  // }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (authController) => InkWell(
          onTap: () {},
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 30),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3.6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset("assets/images/otp.png"),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Phone Number Verification',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                  child: RichText(
                    text: TextSpan(
                        text: "Enter the code sent to ",
                        children: [
                          TextSpan(
                              text: widget.phoneNumber,
                              style: const TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                        style: const TextStyle(color: Colors.black54, fontSize: 15)),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                    child: PinInputTextField(
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        log(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    hasError ? "*Please fill up all the cells properly" : "",
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CustomAsyncBtn(
                    btnTxt: 'Verify',
                    onPress: () async {
                      // Get.toNamed(SignUpScreen.routeName);
                      if (currentText.length != 6) {
                        setState(() {
                          hasError = true;
                        });
                      } else {
                        authController.verifyMobileNo(
                          verificationId: widget.verificationId,
                          smsCode: currentText,
                          mobileNo: widget.phoneNumber,
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Didn't receive the code? ",
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        // _authController.resentVerificationCode(widget.userData);
                      },
                      child: const Text(
                        "RESEND",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

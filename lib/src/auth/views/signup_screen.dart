import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_reservation_app/src/auth/auth_controller.dart';
import 'package:online_reservation_app/utils/constants.dart';
import 'package:online_reservation_app/utils/display_toast_message.dart';
import 'package:online_reservation_app/widgets/custom_async_btn.dart';
import 'package:online_reservation_app/widgets/custom_input_field.dart';

enum UserGender { male, female }

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign-up';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  UserGender? _gender = UserGender.male;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  compressImage(File file) async {
    final filePath = file.absolute.path;

    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      filePath, outPath,
      // minWidth: 1000,
      // minHeight: 1000,
      quality: 68,
    );

    setState(() {
      _image = compressedImage;
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 60,
    );

    if (pickedFile != null) {
      // _image = File(pickedFile.path);
      compressImage(File(pickedFile.path));
      log('picked: $_image');
    } else {
      log('No image selected.');
    }
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );

    if (pickedFile != null) {
      // _image = File(pickedFile.path);
      compressImage(File(pickedFile.path));
      log('picked: $_image');
    } else {
      log('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: GetBuilder<AuthController>(
              builder: (authController) => Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildProfilePicView(),
                        const SizedBox(height: 32.0),
                        CustomInputField(
                          hintText: 'full_name'.tr,
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(Icons.person),
                        ),
                        const SizedBox(height: 10),
                        CustomInputField(
                          hintText: 'email'.tr,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(Icons.email),
                        ),
                        const SizedBox(height: 10),
                        // const SizedBox(height: 10),
                        // CustomInputField(
                        //   hintText: 'Mobile No',
                        //   controller: _mobileNoController,
                        //   keyboardType: TextInputType.phone,
                        // ),
                        _buildGenderView(),
                        const SizedBox(height: 10),
                        CustomInputField(
                          hintText: 'password'.tr,
                          controller: _pwController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: authController.obscureText,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: authController.obscureText
                              ? InkWell(
                                  onTap: () {
                                    authController.obscureText = !authController.obscureText;
                                    authController.update();
                                  },
                                  child: const Icon(Icons.visibility),
                                )
                              : InkWell(
                                  onTap: () {
                                    authController.obscureText = !authController.obscureText;
                                    authController.update();
                                  },
                                  child: const Icon(Icons.visibility_off),
                                ),
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
                          child: CustomAsyncBtn(
                            btnTxt: 'register'.tr,
                            onPress: () async {
                              if (_image != null) {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  await authController.handleSignUp(
                                    user: Get.arguments['user'],
                                    fname: _nameController.text,
                                    email: _emailController.text,
                                    mobileNo: Get.arguments['mobileNo'],
                                    gender: _gender!,
                                    password: _pwController.text,
                                  );
                                }
                              } else {
                                displayToastMessage('Upload Image');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePicView() {
    return InkWell(
      onTap: () {
        _showPicker(context);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          border: Border.all(color: Colors.white, width: 3),
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: _image == null
                  ? Image.asset(
                      'assets/images/dummy_profile.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    )
                  : Image.file(_image!, width: 100, height: 100, fit: BoxFit.cover),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                backgroundColor: const Color(0xff8DBFF6),
                radius: 14,
                child: IconButton(
                  onPressed: () {
                    _showPicker(context);
                  },
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.edit, color: Colors.white, size: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('select_your_gender'.tr, style: kBodyStyle),
        ),
        RadioListTile<UserGender>(
          title: Text('male'.tr),
          value: UserGender.male,
          groupValue: _gender,
          onChanged: (UserGender? value) {
            setState(() {
              _gender = value;
            });
          },
        ),
        RadioListTile<UserGender>(
          title: Text('female'.tr),
          value: UserGender.female,
          groupValue: _gender,
          onChanged: (UserGender? value) {
            setState(() {
              _gender = value;
            });
          },
        ),
      ],
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
            ),
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      getImageFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    getImageFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

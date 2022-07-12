import 'package:flutter/material.dart';
import 'package:get/get.dart';

customSnackBar(titleTxt, msg) {
  Get.snackbar(
    '$titleTxt',
    "$msg",
    margin: const EdgeInsets.all(0),
    backgroundColor: Colors.red[800],
    colorText: Colors.white,
    icon: const Icon(
      Icons.info,
      color: Colors.white,
    ),
    snackPosition: SnackPosition.BOTTOM,
    snackStyle: SnackStyle.GROUNDED,
    shouldIconPulse: true,
  );
}

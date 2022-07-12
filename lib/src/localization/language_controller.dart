import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final GetStorage _getStorage = GetStorage();

  Map<String, dynamic> userLanguage = {};

  late List<bool> toggleLanguage;

  @override
  void onInit() {
    userLanguage = GetStorage().read('language') ??
        {
          'language': 'English',
          'language_code': 'en',
          'country_code': 'US',
        };
    toggleLanguage = userLanguage['language'] == 'English' ? [true, false] : [false, true];
    update();
    log('$userLanguage', name: 'Selected language');
    super.onInit();
  }

  void changeLanguage({
    required String language,
    required String languageCode,
    required String countryCode,
  }) {
    Locale l = Locale(languageCode, countryCode);
    Get.updateLocale(l);
    Map<String, dynamic> langData = {
      'language': language,
      'language_code': languageCode,
      'country_code': countryCode,
    };
    _getStorage.write('language', langData);
    userLanguage = _getStorage.read('language');
  }
}

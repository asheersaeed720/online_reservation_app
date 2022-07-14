import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_reservation_app/src/auth/views/login_screen.dart';
import 'package:online_reservation_app/src/localization/language_controller.dart';
import 'package:online_reservation_app/src/localization/localization.dart';
import 'package:online_reservation_app/src/main_binding.dart';
import 'package:online_reservation_app/src/tab_screen.dart';
import 'package:online_reservation_app/utils/app_theme.dart';
import 'package:online_reservation_app/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        translations: Localization(),
        locale: _languageController.userLanguage.isEmpty
            ? const Locale('en', 'US')
            : Locale(
                _languageController.userLanguage['language_code'],
                _languageController.userLanguage['country_code'],
              ),
        fallbackLocale: const Locale('en', 'US'),
        title: 'Night Live',
        debugShowCheckedModeBanner: false,
        theme: lightThemeData,
        initialBinding: MainBinding(),
        initialRoute:
            FirebaseAuth.instance.currentUser == null ? LogInScreen.routeName : TabScreen.routeName,
        getPages: routes,
      );
}

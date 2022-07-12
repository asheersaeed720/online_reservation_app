import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/localization/language.dart';
import 'package:online_reservation_app/src/localization/language_controller.dart';

class LanguageScreen extends StatefulWidget {
  static const String routeName = '/language';

  const LanguageScreen({Key? key}) : super(key: key);

  static final List<LanguageModel> _languageList = LanguageModel.languageList;

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final _langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 42.0),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.0),
                  color: Colors.white.withOpacity(0.3),
                ),
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 22.0,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Text('Language', style: Theme.of(context).textTheme.bodyText1)
            ],
          ),
          const SizedBox(height: 16.0),
          ...(LanguageScreen._languageList)
              .map(
                (e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GetBuilder<LanguageController>(
                      builder: (_) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: _langController.userLanguage['language_code'] == e.languageCode
                              ? Colors.white.withOpacity(0.4)
                              : Colors.transparent,
                        ),
                        child: ListTile(
                          onTap: () {
                            _langController.changeLanguage(
                              language: e.languageTxt,
                              languageCode: e.languageCode,
                              countryCode: e.countryCode,
                            );
                          },
                          title: Text(
                            e.languageTxt,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          trailing: _langController.userLanguage['language_code'] == e.languageCode
                              ? const Icon(Icons.check, color: Colors.white)
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

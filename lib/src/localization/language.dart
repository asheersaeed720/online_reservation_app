class LanguageModel {
  final String languageTxt;
  final String languageCode;
  final String countryCode;

  LanguageModel({
    required this.languageTxt,
    required this.languageCode,
    required this.countryCode,
  });

  static List<LanguageModel> languageList = [
    LanguageModel(
      languageTxt: 'English',
      languageCode: 'en',
      countryCode: 'US',
    ),
    LanguageModel(
      languageTxt: 'Arabic',
      languageCode: 'ar',
      countryCode: 'SA',
    ),
  ];
}

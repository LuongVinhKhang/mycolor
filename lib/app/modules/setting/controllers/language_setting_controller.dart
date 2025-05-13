import 'dart:ui';

import 'package:get/get.dart';
import 'package:mycolor/app/data/locales.dart';
import 'package:mycolor/app/data_provider/local_storage.dart';

class LanguageSettingController extends GetxController {
  final count = 0.obs;
  final selectedLocale = 'system'.obs;

  @override
  void onInit() {
    super.onInit();

    var localeString = LocalStorage().getLanguage();
    selectedLocale.value = SUPPORTED_LOCALES_MAP.entries.first.key;

    for (MapEntry<String, Locale> entry in SUPPORTED_LOCALES_MAP.entries) {
      if (LocalStorage().localeToString(entry.value) == localeString) {
        selectedLocale.value = entry.key;
      }
    }
  }

  void updateLanguage(String code) {
    selectedLocale.value = code;

    Locale newLocale = SUPPORTED_LOCALES_MAP[code] ?? FALLBACK_LOCALE;

    String localeString = LocalStorage().localeToString(newLocale);

    LocalStorage().setLanguage(localeString);

    Get.updateLocale(newLocale);
  }
}

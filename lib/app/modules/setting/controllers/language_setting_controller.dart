

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mycolor/app/data/locales.dart';
import 'package:mycolor/app/data/enums.dart';

class LanguageSettingController extends GetxController {
  //TODO: Implement LanguageSettingController

  final count = 0.obs;
  final selectedLocale = 'system'.obs;

  @override
  void onInit() {
    super.onInit();
    selectedLocale.value = GetStorage().read(StorageKeys.language) ?? 'system';
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;

//   Locale localeCode2Locale(String code) {
//     if 
//   }

//   String locale2LocaleCode(Locale locale) {
//     String code = locale.languageCode;
//     if (locale.countryCode == null || locale.countryCode == '') {
// code= locale.countryCode;
//     } else {
      
//     }
//   }

  void updateLanguage(String code) {
    selectedLocale.value = code;

    GetStorage().write(StorageKeys.language, code);

    if (code == SYSTEM_LOCALE_KEY) {
      Get.updateLocale(system_locale);
    } else {
      Get.updateLocale(SUPPORTED_LOCALES_MAP[code] ?? FALLBACK_LOCALE);
    }
  }
}

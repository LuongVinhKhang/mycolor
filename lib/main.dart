import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mycolor/app/data/custom_theme.dart';
import 'package:mycolor/app/data/locales.dart';
import 'package:mycolor/app/data/enums.dart';
import 'package:mycolor/app/data_provider/local_storage.dart';

import 'app/routes/app_pages.dart';
import 'app/theme/app_themes.dart';
import 'generated/locales.g.dart';

// https://www.youtube.com/watch?v=hSL6rXnNdBQ

// https://rive.app/preview/?filename=665-1330-tree

// refer for some styling, input validation,
// https://github.com/RipplesCode/PersistentAnimatedDynamicThemeFlutterGetX/blob/master/lib/app/modules/home/views/home_view.dart

// play sound when completed

// log error online
// https://pub.dev/packages/firebase_crashlytics

// get gradient from image?

// this is cool
// https://viblo.asia/p/tao-widget-hinh-ve-xem-phim-voi-customclipper-trong-flutter-gGJ59NmpKX2

// https://flare.rive.app/


// build percent


final box = GetStorage();
var locale;

main() async {
  await initServices();

  bool isDarkMode = LocalStorage().isDarkMode() ?? false;
  LocalStorage().setDarkMode(isDarkMode);

  print('init with darkmode ' + Get.isDarkMode.toString());
  runApp(ThemeProvider(
    initTheme: isDarkMode ? AppThemes.darkThemeData : AppThemes.lightThemeData,
    child: Builder(
      builder: (context) => GetMaterialApp(
        title: "Persistent Theme",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeProvider.of(context),
        // themeMode: ThemeMode.system,
        darkTheme: AppThemes.darkThemeData,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate, // uses `flutter_localizations`
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        translationsKeys: AppTranslation.translations,
        locale: locale,
        fallbackLocale: FALLBACK_LOCALE,
        supportedLocales: SUPPORTED_LOCALES_MAP.values,
      ),
    ),
  ));
}

/**
 * ar_US
 * zh_Hans_US
 * zh_Hant_US
 * tw: zh_Hant_TW
 * flutter: system is zh_Hant_TW
flutter: system is zh
flutter: system is TW
hk zh_Hant_HK zh - Hant - HK
en - null - US

 */

initServices() async {
  print('starting services ...');
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  // get system_locale from GetX
  system_locale = Get.deviceLocale ?? FALLBACK_LOCALE;

  // remove system_locale.countryCode

  print('system is ' + system_locale.toString());
  print(system_locale.languageCode.toString() +
      ' - ' +
      system_locale.scriptCode.toString() +
      ' - ' +
      system_locale.countryCode.toString());
  system_locale = Locale(system_locale.languageCode);

  // get lang code from storage
  var lang = box.read(StorageKeys.language);

  //
  if (lang == null) {
    lang = system_locale.languageCode;
    box.write(StorageKeys.language, lang);
  }

  print('system is ' + system_locale.toString() + ' storage is ' + lang);

  if (lang == system_locale.languageCode) {
    locale = system_locale;
  } else {
    locale = Locale(lang);
  }

  box.listenKey('language', (value) {
    print('new language is $value');
  });
  box.listenKey('theme', (value) {
    print('new theme is $value');
  });

  print('All services started...');
}

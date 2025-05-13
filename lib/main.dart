import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mycolor/app/data/locales.dart';
import 'package:mycolor/app/data_provider/local_storage.dart';

import 'app/routes/app_pages.dart';
import 'app/theme/app_themes.dart';
import 'generated/locales.g.dart';

// https://www.youtube.com/watch?v=hSL6rXnNdBQ

// refer for some styling, input validation,
// https://github.com/RipplesCode/PersistentAnimatedDynamicThemeFlutterGetX/blob/master/lib/app/modules/home/views/home_view.dart

// play sound when completed

// log error online
// https://pub.dev/packages/firebase_crashlytics

// get gradient from image?

// this is cool
// https://viblo.asia/p/tao-widget-hinh-ve-xem-phim-voi-customclipper-trong-flutter-gGJ59NmpKX2

// theme color

// https://flare.rive.app/a/JuanCarlos/files/flare/teddyss

// github action
// https://www.youtube.com/watch?v=rpQKpXjH5vs&ab_channel=RobertBrunhage

// unit test
// https://www.youtube.com/watch?v=1U-QRKIY5so&ab_channel=TadasPetra

// widget test
// https://www.youtube.com/watch?v=7N1qRivtCWI&ab_channel=TadasPetra

// unit test with mock
// https://www.youtube.com/watch?v=5BFlo9k3KNU&ab_channel=FilledStacks

var isDarkMode;
var appLocale;

void main() async {
  await initServices();

  var a = ThemeProvider(
    initTheme: isDarkMode ? AppThemes.darkThemeData : AppThemes.lightThemeData,
    child: Builder(
      builder: (context) => GetMaterialApp(
        locale: DevicePreview.locale(context), // Add the locale here
        builder: DevicePreview.appBuilder, // Add the builder here
        title: 'Focus',
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeProvider.of(context),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        defaultTransition: Transition.cupertino,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate, // uses `flutter_localizations`
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        translationsKeys: AppTranslation.translations,
        // locale: appLocale,
        fallbackLocale: FALLBACK_LOCALE,
        supportedLocales: SUPPORTED_LOCALES_MAP.values,
      ),
    ),
  );

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => a, // Wrap your app
    ),
  );
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

getTheLangFromLocalStorage(String localeString) {
  Locale locale = LocalStorage().stringToLocale(localeString);

  debugPrint('init with language from local storage: ${localeString}');

  return locale;
}

getTheLangFromSystem(Locale? systemLocale) {
  Locale locale;

  if (systemLocale == null) {
    locale = FALLBACK_LOCALE;
    LocalStorage().setLanguage(FALLBACK_LOCALE.languageCode);

    debugPrint('init with sysmtem languauge with fallback locale: [' +
        FALLBACK_LOCALE.languageCode +
        ']');

    return locale;
  }

  String localeString = LocalStorage().localeToString(systemLocale);

  LocalStorage().setLanguage(localeString);

  locale = Locale(systemLocale.languageCode, systemLocale.countryCode);

  debugPrint('init with sysmtem languauge: ' + localeString);

  return locale;
}

initServices() async {
  debugPrint('Starting services ...');
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  // get dark mode
  isDarkMode = LocalStorage().getIsDarkModeRawValue() ?? Get.isPlatformDarkMode;
  LocalStorage().setDarkMode(value: isDarkMode);
  debugPrint('init with darkmode: ${Get.isPlatformDarkMode}');

  // get language
  var langFromStorage = LocalStorage().getLanguageRawValue();

  // first time app open
  if (langFromStorage == null) {
    appLocale = getTheLangFromSystem(Get.deviceLocale);
  } else {
    appLocale = getTheLangFromLocalStorage(langFromStorage);
  }

  print(appLocale.toString());

  debugPrint('All services started...');
}

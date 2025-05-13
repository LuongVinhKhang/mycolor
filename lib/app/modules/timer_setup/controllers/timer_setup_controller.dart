import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mycolor/app/data/constants.dart';
import 'package:mycolor/app/data/locales.dart';
import 'package:mycolor/app/data_provider/local_storage.dart';
import 'package:mycolor/app/theme/app_themes.dart';
import 'package:mycolor/app/utils/full_screen.dart';

class TimerSetupController extends GetxController {
  final isDarkMode = false.obs;

  final timerOnTheScrollWheel = [0].obs;
  final timerList = [0].obs;

  final selectedTimerShortcut = 0.obs;
  final selectedTimer = 0.obs;
  final listWheelScrolling = false.obs;

  @override
  void onInit() {
    super.onInit();

    timerList.value = LocalStorage().getCustomTimer();
    print('timerList.value ' + timerList.value.toString());
    isDarkMode.value = LocalStorage().getIsDarkMode();

    List<int> copy = [];
    copy.addAll(Constants.timerMinutes);
    copy.addAll(timerList);
    copy = copy.toSet().toList();
    copy.sort();

    timerOnTheScrollWheel.value = copy;
    print(timerOnTheScrollWheel.toString());

    setLanguage();
    setFullScreenMode();
  }

  @override
  void onReady() {
    super.onReady();
    setLanguage();
  }

  // Future<void> playAudio() async {
  //   final audio = AudioPlayer();
  //   await audio.setAsset('assets/sounds/numberpicker_sound.mp3');
  //   audio.play();
  // }

  Future<void> playAudio() async {
    // or as a local variable
    final player = AudioCache();
    // call this method when desired
    player.play('sounds/numberpicker_sound.mp3');
  }

  void setLanguage() {
    var localeString = LocalStorage().getLanguageRawValue();

    Locale locale;

    if (localeString == null) {
      Locale systemLocale = Get.deviceLocale ?? FALLBACK_LOCALE;
      locale = Locale(systemLocale.languageCode, systemLocale.countryCode);

      // save back
      localeString = LocalStorage().localeToString(locale);
      LocalStorage().setLanguage(localeString);
    } else {
      locale = LocalStorage().stringToLocale(localeString);
    }

    Get.updateLocale(locale);
  }

  void setFullScreenMode() {
    final value = LocalStorage().getFullScreenMode();

    if (kIsWeb) {
    } else {
      if (value == Constants.noneFullScreenMode) {
        FullScreen.exitFullScreen();
        debugPrint('exitFullScreen()');
      } else {
        final Map<String, FullScreenMode> fullScreenModeList;

        if (Platform.isIOS) {
          fullScreenModeList = Constants.fullScreenModeIos;
        } else {
          // android
          fullScreenModeList = Constants.fullScreenModeAndroid;
        }

        debugPrint('enterFullScreen()');
        FullScreen.enterFullScreen(fullScreenModeList[value]!);
      }
    }
  }

  void changeTheme(BuildContext context) {
    var newTheme = AppThemes.darkThemeData;

    if (isDarkMode.value) {
      debugPrint('change from dark to light');
      newTheme = AppThemes.lightThemeData;
      ThemeSwitcher.of(context)!
          .changeTheme(theme: newTheme, reverseAnimation: false);
    } else {
      debugPrint('change from light to dark');
      ThemeSwitcher.of(context)!
          .changeTheme(theme: newTheme, reverseAnimation: true);
    }

    // Get.changeTheme(newTheme);

    isDarkMode.value = !isDarkMode.value;
    LocalStorage().setDarkMode(value: isDarkMode.value);

    debugPrint(
        'dark mode ${newTheme.brightness.toString()} ${Get.isDarkMode} ${Get.isPlatformDarkMode} ${LocalStorage().getIsDarkMode()}');
  }

  void selectTimerShortcut(int timer) {
    debugPrint('selectTimerShortcut');
    selectedTimerShortcut.value = timer;
  }

  void selectTimer(int timer) {
    debugPrint('selectTimer ' + timer.toString());
    selectedTimer.value = timer;

    selectedTimerShortcut.value = timer;
    playAudio();
  }

  void setListWheelScrolling(bool isScrolling) {
    debugPrint('setListWheelScrolling' + isScrolling.toString());
    listWheelScrolling.value = isScrolling;
  }
}

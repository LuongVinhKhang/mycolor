import 'dart:ui';

import 'package:get_storage/get_storage.dart';
import 'package:mycolor/app/data/colors.dart';
import 'package:mycolor/app/data/constants.dart';
import 'package:mycolor/app/data/enums.dart';

class LocalStorage {
  static const defaultArrayJoinAndSplit = '|';

  void reset() {
    GetStorage().erase();
  }

  List<String>? _getArray(String key) {
    if (GetStorage().hasData(key) == false) {
      return null;
    }

    final dataAsString = GetStorage().read<String>(key).toString();

    if (dataAsString.isEmpty) {
      return [];
    }

    final dataAsStringArray = dataAsString.split(defaultArrayJoinAndSplit);

    return dataAsStringArray;
  }

  void _setArray(String key, List<String>? array) {
    if (array == null) {
      return;
    }

    final data = array.join(defaultArrayJoinAndSplit);

    GetStorage().write(key, data);
  }

  List<Color>? _getColors(String key) {
    final dataAsStringArray = _getArray(key);

    if (dataAsStringArray == null) {
      return null;
    }

    final dataAsColorArray = dataAsStringArray
        .map((e) =>
            Color(int.tryParse(e) ?? ColorConstants.defaultFallbackColor.value))
        .toList();

    return dataAsColorArray;
  }

  void _setColors(String key, List<Color> colors) {
    return _setArray(key, colors.map((e) => e.value.toString()).toList());
  }

  List<int> getCustomTimer() {
    final dataAsStringArray = _getArray(StorageKeys.customTimer);

    if (dataAsStringArray == null) {
      return Constants.defaultShortcutTimerMinutes;
    }

    if (dataAsStringArray.length == 0) {
      return [];
    }

    final dataAsArray = dataAsStringArray
        .map(
            (e) => int.tryParse(e) ?? ColorConstants.defaultFallbackColor.value)
        .toList();

    return dataAsArray;
  }

  void setCustomTimer(List<int> timer) {
    return _setArray(
        StorageKeys.customTimer, timer.map((e) => e.toString()).toList());
  }

  List<Color> getBackgroundColors() {
    return _getColors(StorageKeys.backgroundColors) ??
        ColorConstants.defaultBackgroundColor;
  }

  void setBackgroundColors(List<Color> colors) {
    return _setColors(StorageKeys.backgroundColors, colors);
  }

  List<Color> getWaveColors() {
    return _getColors(StorageKeys.waveColors) ??
        ColorConstants.defaultWaveColor;
  }

  void setWaveColors(List<Color> colors) {
    return _setColors(StorageKeys.waveColors, colors);
  }

  String getFullScreenMode() {
    return GetStorage().read(StorageKeys.fullScreenMode) ??
        Constants.noneFullScreenMode;
  }

  void setFullScreenMode(String value) {
    GetStorage().write(StorageKeys.fullScreenMode, value);
  }

  // TODO: move logic out of local storage
  Locale stringToLocale(String localeString) {
    Locale locale;
    if (localeString.contains('_')) {
      var languageCode = localeString.split('_')[0];
      var countryCode = localeString.split('_')[1];

      locale = Locale(languageCode, countryCode);
    } else {
      locale = Locale(localeString);
    }
    return locale;
  }

  // TODO: move logic out of local storage
  String localeToString(Locale locale) {
    String localeString;
    var languageCode = locale.languageCode;
    var countryCode = locale.countryCode;

    // for zh if countryCode is not TW, set back to CN
    // if not zh, remove countryCode
    if (languageCode == 'zh' && countryCode != 'TW') {
      countryCode = 'CN';
    } else {
      countryCode = '';
    }

    if (countryCode == '') {
      locale = Locale(languageCode);
      localeString = languageCode;
    } else {
      locale = Locale(languageCode, countryCode);
      localeString = languageCode + '_' + countryCode;
    }

    return localeString;
  }

  String? getLanguageRawValue() {
    return GetStorage().read(StorageKeys.language);
  }

  String getLanguage() {
    return GetStorage().read(StorageKeys.language) ?? Constants.languageDefault;
  }

  void setLanguage(String value) {
    GetStorage().write(StorageKeys.language, value);
  }

  bool? getIsDarkModeRawValue() {
    return GetStorage().read(StorageKeys.isDarkMode);
  }

  bool getIsDarkMode() {
    return GetStorage().read(StorageKeys.isDarkMode) ??
        Constants.isDarkModeDefault;
  }

  void setDarkMode({bool? value}) {
    GetStorage().write(StorageKeys.isDarkMode, value);
  }

  String getWaveDirection() {
    return GetStorage().read(StorageKeys.waveDirection) ??
        Constants.waveDirectionDefault;
  }

  void setWaveDirection(String value) {
    GetStorage().write(StorageKeys.waveDirection, value);
  }

  bool getIsShowBackButton() {
    return GetStorage().read(StorageKeys.isShowBackButton) ??
        Constants.isShowBackButtonDefault;
  }

  void setIsShowBackButton({bool? value}) {
    GetStorage().write(StorageKeys.isShowBackButton, value);
  }

  bool getIsShowPercentage() {
    return GetStorage().read(StorageKeys.isShowPercentage) ??
        Constants.isShowPercentageDefault;
  }

  void setIsShowPercentage({bool? value}) {
    GetStorage().write(StorageKeys.isShowPercentage, value);
  }

  bool getIsShowTimer() {
    return GetStorage().read(StorageKeys.isShowTimer) ??
        Constants.isShowTimerDefault;
  }

  void setIsShowTimer({bool? value}) {
    GetStorage().write(StorageKeys.isShowTimer, value);
  }
}

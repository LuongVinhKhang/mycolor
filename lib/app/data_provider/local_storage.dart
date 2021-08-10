import 'dart:ui';

import 'package:get_storage/get_storage.dart';
import 'package:mycolor/app/data/enums.dart';

class LocalStorage {
  static const DEFAULT_ARRAY_JOIN_AND_SPLIT = '|';

  void reset() {
    GetStorage().erase();
  }

  List<Color>? _getColors(String key) {
    if (!GetStorage().hasData(key)) {
      return null;
    }

    final dataAsStringArray = GetStorage()
        .read<String>(key)
        .toString()
        .split(DEFAULT_ARRAY_JOIN_AND_SPLIT);

    print(dataAsStringArray.toString());

    final dataAsColorArray = dataAsStringArray
        .map((e) => Color(
            int.tryParse(e) ?? ColorConstants.DEFAULT_FALLBACK_COLOR.value))
        .toList();

    return dataAsColorArray;
  }

  void _setColors(String key, List<Color> colors) {
    var data = colors
        .map((e) => e.value.toString())
        .join(DEFAULT_ARRAY_JOIN_AND_SPLIT);
    GetStorage().write(key, data);
  }

  List<Color>? getBackgroundColors() {
    return _getColors(StorageKeys.backgroundColors);
  }

  void setBackgroundColors(List<Color> colors) {
    return _setColors(StorageKeys.backgroundColors, colors);
  }

  List<Color>? getWaveColors() {
    return _getColors(StorageKeys.waveColors);
  }

  void setWaveColors(List<Color> colors) {
    return _setColors(StorageKeys.waveColors, colors);
  }

  bool? isDarkMode() {
    return GetStorage().read(StorageKeys.isDarkMode) ?? false;
  }

  void setDarkMode(bool value) {
    GetStorage().write(StorageKeys.isDarkMode, value);
  }

  String? getWaveDirection() {
    return GetStorage().read(StorageKeys.waveDirection);
  }

  void setWaveDirection(String value) {
    GetStorage().write(StorageKeys.waveDirection, value);
  }

  bool? getIsShowPercentage() {
    return GetStorage().read(StorageKeys.isShowPercentage);
  }

  void setIsShowPercentage(String value) {
    GetStorage().write(StorageKeys.isShowPercentage, value);
  }

  bool? getIsShowTimer() {
    return GetStorage().read(StorageKeys.isShowTimer);
  }

  void setIsShowTimer(String value) {
    GetStorage().write(StorageKeys.isShowTimer, value);
  }
}

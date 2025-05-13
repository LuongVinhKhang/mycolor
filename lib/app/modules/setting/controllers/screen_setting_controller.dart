import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mycolor/app/data/constants.dart';
import 'package:mycolor/app/data/enums.dart';
import 'package:mycolor/app/data_provider/local_storage.dart';
import 'package:mycolor/app/utils/full_screen.dart';

class ScreenSettingController extends GetxController {
  final showScreenSetting = true.obs;
  final fullScreenModeList = {}.obs;
  final fullScreenModeSelected = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fullScreenModeSelected.value =
        GetStorage().read(StorageKeys.fullScreenMode) ??
            Constants.noneFullScreenMode;

    if (kIsWeb) {
    } else {
      if (Platform.isIOS) {
        fullScreenModeList.value = Constants.fullScreenModeIos;
      } else if (Platform.isAndroid) {
        fullScreenModeList.value = Constants.fullScreenModeAndroid;
      } else {
        showScreenSetting.value = false;
      }
    }
  }

  @override
  void onClose() {}

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  void setFullScreenMode(String? value) {
    value ??= Constants.noneFullScreenMode;

    if (value == Constants.noneFullScreenMode) {
      FullScreen.exitFullScreen();
    } else {
      FullScreen.enterFullScreen(fullScreenModeList[value]);
    }

    fullScreenModeSelected.value = value;
    LocalStorage().setFullScreenMode(value);
  }
}

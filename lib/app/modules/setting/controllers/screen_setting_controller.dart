import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mycolor/app/data/constants.dart';
import 'package:mycolor/app/data/enums.dart';
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
            Constants.NONE_FULL_SCREEN_MODE;

    if (Platform.isIOS) {
      fullScreenModeList.value = Constants.FULL_SCREEN_MODE_IOS;
    } else if (Platform.isAndroid) {
      fullScreenModeList.value = Constants.FULL_SCREEN_MODE_ANDROID;
    } else {
      showScreenSetting.value = false;
    }
  }

  void setFullScreenMode(String? value) {
    if (value == null) {
      value = Constants.NONE_FULL_SCREEN_MODE;
    }
    if (value == Constants.NONE_FULL_SCREEN_MODE) {
      FullScreen.exitFullScreen();
    } else {
      FullScreen.enterFullScreen(fullScreenModeList[value]);
    }

    GetStorage().write(StorageKeys.fullScreenMode, value);
    fullScreenModeSelected.value = value;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

import 'package:get/get.dart';

import 'package:mycolor/app/modules/setting/controllers/wave_text_setting_controller.dart';
import 'package:mycolor/app/modules/setting/controllers/direction_setting_controller.dart';
import 'package:mycolor/app/modules/setting/controllers/language_setting_controller.dart';
import 'package:mycolor/app/modules/setting/controllers/screen_setting_controller.dart';
import 'package:mycolor/app/modules/setting/controllers/theme_setting_controller.dart';
import 'package:mycolor/app/modules/setting/controllers/timer_setting_controller.dart';

import '../controllers/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WaveTextSettingController>(
      () => WaveTextSettingController(),
    );
    Get.lazyPut<DirectionSettingController>(
      () => DirectionSettingController(),
    );
    Get.lazyPut<TimerSettingController>(
      () => TimerSettingController(),
    );
    Get.lazyPut<ScreenSettingController>(
      () => ScreenSettingController(),
    );
    Get.lazyPut<ThemeSettingController>(
      () => ThemeSettingController(),
    );
    Get.lazyPut<LanguageSettingController>(
      () => LanguageSettingController(),
    );
    Get.lazyPut<SettingController>(
      () => SettingController(),
    );
  }
}

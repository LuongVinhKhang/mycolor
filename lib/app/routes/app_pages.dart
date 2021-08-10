import 'package:get/get.dart';

import 'package:mycolor/app/modules/color_setting/bindings/color_setting_binding.dart';
import 'package:mycolor/app/modules/color_setting/views/color_setting_view.dart';
import 'package:mycolor/app/modules/home/bindings/home_binding.dart';
import 'package:mycolor/app/modules/home/views/home_view.dart';
import 'package:mycolor/app/modules/setting/bindings/setting_binding.dart';
import 'package:mycolor/app/modules/setting/views/setting_view.dart';
import 'package:mycolor/app/modules/timer_setup/bindings/timer_setup_binding.dart';
import 'package:mycolor/app/modules/timer_setup/views/timer_setup_view.dart';
import 'package:mycolor/app/modules/wave_progress/bindings/wave_progress_binding.dart';
import 'package:mycolor/app/modules/wave_progress/views/wave_progress_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.WAVE_PROGRESS,
      page: () => WaveProgressView(),
      binding: WaveProgressBinding(),
    ),
    GetPage(
      name: _Paths.TIMER_SETUP,
      page: () => TimerSetupView(),
      binding: TimerSetupBinding(),
    ),
    GetPage(
      name: _Paths.COLOR_SETTING,
      page: () => ColorSettingView(),
      binding: ColorSettingBinding(),
    ),
  ];
}

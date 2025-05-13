import 'package:get/get.dart';

import '../controllers/color_setting_controller.dart';

class ColorSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ColorSettingController>(
      () => ColorSettingController(),
    );
  }
}

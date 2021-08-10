import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mycolor/app/modules/setting/controllers/screen_setting_controller.dart';
import 'package:mycolor/generated/locales.g.dart';

class ScreenSettingView extends GetView<ScreenSettingController> {
  _buildScreenSettingForPhone() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ListTile(
            title: Text(LocaleKeys.select_your_full_screen_mode.tr),
          ),
        ]..addAll(controller.fullScreenModeList.keys
            .toList()
            .map((e) => Obx(() => RadioListTile<String>(
                  value: e,
                  title: Text(e),
                  groupValue: controller.fullScreenModeSelected.value,
                  onChanged: (value) {
                    controller.setFullScreenMode(value);
                  },
                )))
            .toList()));
  }

  @override
  Widget build(BuildContext context) {
    if (controller.showScreenSetting.value) {
      return _buildScreenSettingForPhone();
    } else {
      return Container();
    }
  }
}

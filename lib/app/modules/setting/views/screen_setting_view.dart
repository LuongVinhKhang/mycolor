import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mycolor/app/modules/setting/controllers/screen_setting_controller.dart';
import 'package:mycolor/generated/locales.g.dart';

class ScreenSettingView extends GetView<ScreenSettingController> {
  Widget _buildScreenSettingForPhone() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ListTile(
            title: Text(LocaleKeys.setting_full_screen_mode.tr),
          ),
          ...controller.fullScreenModeList.keys
              .toList()
              .map((dynamic e) => Obx(() => RadioListTile<String>(
                    value: e.toString(),
                    title: Text(e.toString()),
                    groupValue: controller.fullScreenModeSelected.value,
                    onChanged: (value) {
                      controller.setFullScreenMode(value);
                    },
                  )))
              .toList(),
        ]);
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

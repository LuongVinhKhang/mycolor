import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mycolor/app/data/constants.dart';
import 'package:mycolor/app/modules/setting/controllers/direction_setting_controller.dart';
import 'package:mycolor/generated/locales.g.dart';

class DirectionSettingView extends GetView<DirectionSettingController> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text(LocaleKeys.setting_wave_direction.tr),
      ),
      Obx(() => RadioListTile<String>(
            value: Constants.waveDirectionUp,
            title: ListTile(
                title: Text(LocaleKeys.setting_wave_direction_up.tr),
                leading: Icon(Icons.arrow_upward_rounded)),
            groupValue: controller.directionSelected.value,
            onChanged: (value) {
              controller.setDirection(value);
            },
          )),
      Obx(() => RadioListTile<String>(
            value: Constants.waveDirectionDown,
            title: ListTile(
                title: Text(LocaleKeys.setting_wave_direction_down.tr),
                leading: Icon(Icons.arrow_downward_rounded)),
            groupValue: controller.directionSelected.value,
            onChanged: (value) {
              controller.setDirection(value);
            },
          ))
    ]);
  }
}

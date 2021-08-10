import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mycolor/app/data/constants.dart';
import 'package:mycolor/app/modules/setting/controllers/direction_setting_controller.dart';

class DirectionSettingView extends GetView<DirectionSettingController> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text('Direction'),
      ),
      Obx(() => RadioListTile<String>(
            value: Constants.WAVE_DIRECTION_UP,
            title: ListTile(
                title: Text('Up'), leading: Icon(Icons.arrow_upward_rounded)),
            groupValue: controller.directionSelected.value,
            onChanged: (value) {
              controller.setDirection(value);
            },
          )),
      Obx(() => RadioListTile<String>(
            value: Constants.WAVE_DIRECTION_DOWN,
            title: ListTile(
                title: Text('Down'),
                leading: Icon(Icons.arrow_downward_rounded)),
            groupValue: controller.directionSelected.value,
            onChanged: (value) {
              controller.setDirection(value);
            },
          ))
    ]);
  }
}

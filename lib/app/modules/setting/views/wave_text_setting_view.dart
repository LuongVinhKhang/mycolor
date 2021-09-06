import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mycolor/app/modules/setting/controllers/wave_text_setting_controller.dart';
import 'package:mycolor/generated/locales.g.dart';

class WaveTextSettingView extends GetView<WaveTextSettingController> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text(LocaleKeys.setting_show_on_the_wave_progress.tr),
      ),
      Obx(() => CheckboxListTile(
            value: controller.isShowBackButton.value,
            title: Text(LocaleKeys
                .setting_show_on_the_wave_progress_show_back_button.tr),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              controller.setIsShowBackButton(value);
            },
          )),
      Obx(() => CheckboxListTile(
            value: controller.isShowPercentage.value,
            title: Text(LocaleKeys
                .setting_show_on_the_wave_progress_show_percentage_text.tr),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              controller.setIsShowPercentage(value);
            },
          )),
      Obx(() => CheckboxListTile(
            value: controller.isShowTimer.value,
            title: Text(LocaleKeys
                .setting_show_on_the_wave_progress_show_timer_text.tr),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              controller.setIsShowTimer(value);
            },
          ))
    ]);
  }
}

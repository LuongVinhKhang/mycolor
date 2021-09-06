import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mycolor/app/data/locales.dart';
import 'package:mycolor/app/modules/setting/controllers/language_setting_controller.dart';
import 'package:mycolor/generated/locales.g.dart';

class LanguageSettingView extends GetView<LanguageSettingController> {
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Column(children: [
      ListTile(
        title: Text(LocaleKeys.setting_language.tr),
      ),
      Obx(
        () => ListTile(
            title: Text(
          '${controller.count.toString()} ${LocaleKeys.test_text.tr}',
          style: TextStyle(fontSize: 20),
        )),
      ),
      ...SUPPORTED_LOCALES_MAP.keys.toList().map((e) => Obx(() => RadioListTile(
            value: e,
            title: Text(e),
            groupValue: controller.selectedLocale.value,
            onChanged: (value) {
              controller.updateLanguage(value.toString());
            },
          ))),
    ]);
  }
}

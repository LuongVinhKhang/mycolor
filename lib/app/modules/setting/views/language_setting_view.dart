import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mycolor/app/data/locales.dart';
import 'package:mycolor/app/modules/setting/controllers/language_setting_controller.dart';
import 'package:mycolor/generated/locales.g.dart';

class LanguageSettingView extends GetView<LanguageSettingController> {
  @override
  Widget build(BuildContext context) {
    print(SUPPORTED_LOCALES_MAP.keys.toList().toString());
    return Column(
        children: [
      ListTile(
        title: Text('Language'),
      ),
      Obx(
        () => ListTile(
            title: Text(
          '${controller.count.toString()} ${LocaleKeys.test_text.tr}',
          style: TextStyle(fontSize: 20),
        )),
      ),
    ]..addAll(SUPPORTED_LOCALES_MAP.keys
            .toList()
            .map((e) => Obx(() => RadioListTile(
                  value: e,
                  title: Text(e),
                  groupValue: controller.selectedLocale.value,
                  onChanged: (String? value) {
                    print(value);
                    controller.updateLanguage(value ?? SYSTEM_LOCALE_KEY);
                  },
                )))));
  }
}

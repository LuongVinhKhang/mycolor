import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mycolor/app/modules/setting/controllers/timer_setting_controller.dart';
import 'package:mycolor/generated/locales.g.dart';

class TimerSettingView extends GetView<TimerSettingController> {
  final context = Get.context!;

  Future<void> _showTextInputDialog() async {
    final result = await showTextInputDialog(
      barrierDismissible: true,
      context: context,
      title: LocaleKeys.setting_timer_shortcut_add_popup_title.tr,
      okLabel: LocaleKeys.setting_timer_shortcut_add_popup_ok_button.tr,
      cancelLabel: LocaleKeys.setting_timer_shortcut_add_popup_cancel_button.tr,
      textFields: [
        DialogTextField(
            keyboardType: TextInputType.number,
            hintText: LocaleKeys.setting_timer_shortcut_add_popup_hint.tr,
            validator: (value) {
              String? result = null;
              if (value!.isEmpty) {
                result =
                    LocaleKeys.setting_timer_shortcut_add_popup_error_empty.tr;
              } else if (int.tryParse(value[0]) == null) {
                result =
                    LocaleKeys.setting_timer_shortcut_add_popup_error_nan.tr;
              }
              return result;
            }),
      ],
    );

    if (result != null &&
        result.length != 0 &&
        result[0] != "" &&
        int.tryParse(result[0]) != null) {
      controller.addTimer(int.parse(result[0]));
    }
  }

  Widget _buildChip(int timer) {
    return Chip(
      label: Text(timer.toString() + ' ' + LocaleKeys.min.tr),
      onDeleted: () {
        controller.deleteTimer(timer);
      },
    );
  }

  Widget _buildChipWithTooltip(int timer) {
    return Tooltip(
        message: LocaleKeys.setting_timer_shortcut_warning.tr,
        child: Chip(
          avatar: Icon(Icons.error_outline_rounded),
          label: Text(timer.toString() + ' ' + LocaleKeys.min.tr),
          onDeleted: () {
            controller.deleteTimer(timer);
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(controller.timerList.toString());
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ListTile(
              title: Text(LocaleKeys.setting_timer_shortcut.tr),
              trailing: IconButton(
                  onPressed: () async {
                    _showTextInputDialog();
                  },
                  icon: const Icon(Icons.add))),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Obx(
              () => Wrap(
                  spacing: 20,
                  runSpacing: 10,
                  children: controller.timerList
                      .toList()
                      .map((element) => element % 5 == 0
                          ? _buildChip(element)
                          : _buildChipWithTooltip(element))
                      .toList()),
            ),
          )
        ]);
  }
}

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mycolor/app/data_provider/local_storage.dart';
import 'package:mycolor/app/modules/setting/views/direction_setting_view.dart';
import 'package:mycolor/app/modules/setting/views/language_setting_view.dart';
import 'package:mycolor/app/modules/setting/views/screen_setting_view.dart';
import 'package:mycolor/app/modules/setting/views/timer_setting_view.dart';
import 'package:mycolor/app/modules/setting/views/wave_text_setting_view.dart';
import 'package:mycolor/app/modules/timer_setup/views/timer_setup_view.dart';
import 'package:mycolor/app/routes/app_pages.dart';
import 'package:mycolor/generated/locales.g.dart';
import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  final context = Get.context!;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: 'update_view');
        return true;
      },
      child: ThemeSwitchingArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.setting_title.tr),
              centerTitle: true,
              actions: [
                // TODO: not implemented completely
                Visibility(
                  visible: false,
                  child: IconButton(
                      onPressed: () async {
                        final result = await showOkCancelAlertDialog(
                          context: context,
                          title: LocaleKeys.setting_reset_popup_title.tr,
                          message: LocaleKeys.setting_reset_popup_message.tr,
                          okLabel: LocaleKeys.setting_reset_popup_ok_button.tr,
                          cancelLabel:
                              LocaleKeys.setting_reset_popup_cancel_button.tr,
                          barrierDismissible: true,
                          isDestructiveAction: true,
                        );
                        debugPrint(result.toString());

                        if (result == OkCancelResult.ok) {
                          LocalStorage().reset();
                          Get.back(result: 'reset');
                          Get.reset();
                        }
                      },
                      icon: Icon(Icons.restore)),
                )
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  ListTile(
                    title: Text(LocaleKeys.setting_color_setup.tr),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Get.toNamed(Routes.COLOR_SETTING);
                    },
                  ),
                  WaveTextSettingView(),
                  TimerSettingView(),
                  DirectionSettingView(),
                  ScreenSettingView(),
                  // ThemeSettingView(),
                  LanguageSettingView(),
                ],
              )),
            )),
      ),
    );
  }
}

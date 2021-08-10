import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mycolor/app/data_provider/local_storage.dart';
import 'package:mycolor/app/modules/setting/views/direction_setting_view.dart';
import 'package:mycolor/app/modules/setting/views/language_setting_view.dart';
import 'package:mycolor/app/modules/setting/views/screen_setting_view.dart';
import 'package:mycolor/app/modules/setting/views/theme_setting_view.dart';
import 'package:mycolor/app/modules/setting/views/timer_setting_view.dart';
import 'package:mycolor/app/routes/app_pages.dart';
import 'package:mycolor/generated/locales.g.dart';
import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('SettingView'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    LocalStorage().reset();
                  },
                  icon: Icon(Icons.restore))
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
              children: [
                ListTile(
                  title: Text('Color setup'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Get.toNamed(Routes.COLOR_SETTING);
                  },
                ),
                TimerSettingView(),
                DirectionSettingView(),
                ScreenSettingView(),
                // ThemeSettingView(),

                LanguageSettingView(),
              ],
            )),
          )),
    );
  }
}

import 'dart:ui';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mycolor/app/global_widgets/cat_view.dart';
import 'package:mycolor/app/global_widgets/clickable_list_wheel_widget.dart';
import 'package:mycolor/app/global_widgets/teddy_view.dart';
import 'package:mycolor/app/routes/app_pages.dart';
import 'package:mycolor/generated/locales.g.dart';

import '../controllers/timer_setup_controller.dart';

class TimerSetupView extends GetView<TimerSetupController> {
  static const scrollItemHeight = 80.0;
  final _scrollController = FixedExtentScrollController();

  Widget _buildShortcutOption() {
    return Obx(() => Wrap(
          children: controller.timerList
              .toList()
              .map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: controller.selectedTimerShortcut.value == e
                      ? ElevatedButton(
                          onPressed: () {},
                          style: const ButtonStyle(),
                          child: Text(
                            '$e ${LocaleKeys.min.tr}',
                            style: const TextStyle(fontSize: 20),
                          ))
                      : OutlinedButton(
                          onPressed: () {
                            controller.selectTimerShortcut(e);
                            var index = -1;
                            for (var i = 0;
                                i < controller.timerOnTheScrollWheel.length;
                                i++) {
                              if (controller.timerOnTheScrollWheel[i] == e) {
                                index = i;
                                break;
                              }
                            }
                            if (index == -1) {
                              index = 0;
                            }
                            controller.selectTimer(
                                controller.timerOnTheScrollWheel[index]);
                            controller.setListWheelScrolling(true);
                            _scrollController
                                .animateTo(scrollItemHeight * index.toDouble(),
                                    duration:
                                        const Duration(milliseconds: 1500),
                                    curve: Curves.ease)
                                .then((value) =>
                                    {controller.setListWheelScrolling(false)});
                          },
                          child: Text(
                            '$e ${LocaleKeys.min.tr}',
                            style: const TextStyle(fontSize: 20),
                          ))))
              .toList(),
        ));
  }

  Widget _buildScrollWheel() {
    return Obx(
      () => ClickableListWheelScrollView(
        scrollController: _scrollController,
        itemHeight: scrollItemHeight,
        itemCount: controller.timerOnTheScrollWheel.length,
        child: ListWheelScrollView(
          controller: _scrollController,
          itemExtent: 80,
          overAndUnderCenterOpacity: 0.3,
          perspective: 0.0000000001,
          physics: const FixedExtentScrollPhysics(),
          onSelectedItemChanged: (index) {
            controller.playAudio();
            if (!controller.listWheelScrolling.value) {
              controller.selectTimer(controller.timerOnTheScrollWheel[index]);
            }
          },
          children: controller.timerOnTheScrollWheel
              .toList()
              .map<Widget>((e) => Container(
                    height: 100,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        e.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 50),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildScroll() {
    return Container(
      height: 300,
      child: Stack(children: [
        // Center(
        //   child: Container(
        //     width: double.infinity,
        //     height: 300,
        //     decoration: new BoxDecoration(
        //         shape: BoxShape.circle,
        //         border: Border.all(width: 10, color: Colors.cyan)),
        //   ),
        // ),
        _buildScrollWheel(),
        Center(
          child: Container(
            width: 300,
            height: 80,
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(
                color: Theme.of(Get.context!).iconTheme.color!,
                width: 2,
              ),
              bottom: BorderSide(
                color: Theme.of(Get.context!).iconTheme.color!,
                width: 2,
              ),
            )),
            child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  LocaleKeys.min.tr,
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w100),
                )),
          ),
        )
      ]),
    );
  }

  Widget _buildButton() {
    return TextButton(
        onPressed: () {
          debugPrint(controller.selectedTimer.value.toString());
          Get.toNamed(Routes.WAVE_PROGRESS,
              arguments: {'selectedTimer': controller.selectedTimer.value});
        },
        child: Text(
          LocaleKeys.timer_setup_lets_go.tr,
          style: const TextStyle(fontSize: 30),
        ));
  }

  Widget _buildTree() {
    // return CatView(catState: 'Walk');
    return TeddyView(teddyState: "Idle");
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(LocaleKeys.timer_setup_title.tr),
          centerTitle: true,
          leading: ThemeSwitcher(
              key: Key("ThemeSwitcher"),
              builder: (context) => Obx(() => IconButton(
                    icon: controller.isDarkMode.value
                        ? const Icon(
                            CupertinoIcons.brightness,
                          )
                        : const Icon(
                            CupertinoIcons.moon_stars,
                          ),
                    onPressed: () {
                      controller.changeTheme(context);
                    },
                  ))),
          actions: [
            IconButton(
                onPressed: () async {
                  final data = await Get.toNamed(Routes.SETTING);
                  if (data == 'update_view') {
                    controller.onInit();
                  }
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            print(constraints.maxHeight);
            return Column(children: [
              _buildScroll(),
              _buildShortcutOption(),
              _buildButton(),
              if (constraints.maxHeight > 712)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 300,
                    child: _buildTree(),
                  ),
                ),
            ]);
          },
        ),
      ),
    );
  }
}

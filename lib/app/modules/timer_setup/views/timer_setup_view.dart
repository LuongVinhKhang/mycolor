import 'dart:ui';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mycolor/app/data/constants.dart';
import 'package:mycolor/app/global_widgets/cat_view.dart';
import 'package:mycolor/app/global_widgets/clickable_list_wheel_widget.dart';
import 'package:mycolor/app/global_widgets/play_pause_view.dart';
import 'package:mycolor/app/routes/app_pages.dart';

import '../controllers/timer_setup_controller.dart';

class TimerSetupView extends GetView<TimerSetupController> {
  static const SCROLL_ITEM_HEIGHT = 80.0;
  final _scrollController = new FixedExtentScrollController();

  _buildShortcutOption() {
    return Obx(() => Wrap(
          children: controller.timerList
              .toList()
              .map((e) => Padding(
                  padding: EdgeInsets.all(8.0),
                  child: controller.selectedTimerShortcut.value == e
                      ? ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(),
                          child: Text(
                            e.toString() + " min",
                            style: TextStyle(fontSize: 20),
                          ))
                      : OutlinedButton(
                          onPressed: () {
                            controller.selectTimerShortcut(e);
                            int index = -1;
                            for (int i = 0;
                                i < Constants.TIMER_MINUTES.length;
                                i++) {
                              if (Constants.TIMER_MINUTES[i] == e) {
                                index = i;
                                break;
                              }
                            }
                            if (index == -1) {
                              index = 0;
                            }
                            controller
                                .selectTimer(Constants.TIMER_MINUTES[index]);
                            controller.setListWheelScrolling(true);
                            _scrollController
                                .animateTo(
                                    SCROLL_ITEM_HEIGHT * index.toDouble(),
                                    duration: new Duration(seconds: 4),
                                    curve: Curves.ease)
                                .then((value) =>
                                    {controller.setListWheelScrolling(false)});
                          },
                          style: ButtonStyle(),
                          child: Text(
                            e.toString() + " min",
                            style: TextStyle(fontSize: 20),
                          ))))
              .toList(),
        ));
  }

  _buildScrollWheel() {
    return ClickableListWheelScrollView(
      scrollController: _scrollController,
      itemHeight: SCROLL_ITEM_HEIGHT,
      itemCount: Constants.TIMER_MINUTES.length,
      child: ListWheelScrollView(
        controller: _scrollController,
        itemExtent: 80,
        overAndUnderCenterOpacity: 0.3,
        perspective: 0.0000000001,
        physics: FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) => {
          if (!controller.listWheelScrolling.value)
            {controller.selectTimer(Constants.TIMER_MINUTES[index])}
        },
        children: Constants.TIMER_MINUTES
            .map((e) => Container(
                  height: 100,
                  decoration: BoxDecoration(
                      // color: Colors.amber,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Center(
                    child: Text(
                      e.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  _buildScroll() {
    return Container(
      height: 300,
      child: Stack(children: [
        // Center(
        //   child: Container(
        //     width: double.infinity,
        //     height: 300,
        //     decoration: new BoxDecoration(
        //         shape: BoxShape.circle, border: Border.all(color: Colors.cyan)),
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
                color: Colors.black38,
                width: 1.0,
              ),
              bottom: BorderSide(
                color: Colors.black38,
                width: 1.0,
              ),
            )),
            child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'min',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w100),
                )),
          ),
        )
      ]),
    );
  }

  _buildButton() {
    return TextButton(
        onPressed: () {
          print(controller.selectedTimer.value);
          Get.toNamed(Routes.WAVE_PROGRESS,
              arguments: {'selectedTimer': controller.selectedTimer.value});
        },
        child: Text(
          'Let\'s go',
          style: TextStyle(fontSize: 30),
        ));
  }

  _buildTree() {
    return CatView(catState: 'Walk');
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('TimerSetupView'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            _buildScroll(),
            _buildShortcutOption(),
            _buildButton(),
            // Spacer(),
            // Placeholder(fallbackHeight: 200,),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 300,
                child: _buildTree(),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

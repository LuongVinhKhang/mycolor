import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mycolor/app/data/constants.dart';
import 'package:mycolor/app/data_provider/local_storage.dart';
import 'package:mycolor/app/global_widgets/pausable_timer.dart';

class WaveProgressController extends GetxController {
  final totalMS = 0.obs;
  final currentPercentage = 0.1.obs;
  final currentMS = 0.obs;

  final timeUpped = false.obs;
  final timePaused = false.obs;

  static const perTickMS = 100;
  late final String waveDirection;
  late final bool isShowPercentage;
  late final bool isShowTimer;
  late PausableTimer _timer;
  final confettiController =
      ConfettiController(duration: const Duration(seconds: 10)).obs;

  late final List<Color> backgroudColors;
  late final List<Color> waveColors;

  @override
  void onInit() {
    super.onInit();

    backgroudColors = LocalStorage().getBackgroundColors();
    waveColors = LocalStorage().getWaveColors();

    waveDirection = LocalStorage().getWaveDirection();
    isShowPercentage = LocalStorage().getIsShowPercentage();
    isShowTimer = LocalStorage().getIsShowTimer();

    var minutes = 15;

    if (Get.arguments != null) {
      minutes = int.parse(Get.arguments!['selectedTimer'].toString());
    }

    minutes = 1;

    totalMS.value = minutes * 60 * 1000 ~/ 4;

    if (waveDirection == Constants.waveDirectionUp) {
      currentMS.value = 0;
    } else if (waveDirection == Constants.waveDirectionDown) {
      currentMS.value = totalMS.value;
    } else {
      throw UnimplementedError();
    }

    startTimer();

    playAudio();
  }

  @override
  void onClose() {
    _timer.cancel();
  }

  void setPercentage() {
    debugPrint('setPercentage');
  }

  Future<void> playAudio() async {
    // or as a local variable
    final player = AudioCache();
    // call this method when desired
    player.play('sounds/field.mp3');
  }

  void startTimer() {
    const duration = Duration(milliseconds: perTickMS);
    _timer = PausableTimer(
      duration,
      () {
        if (waveDirection == Constants.waveDirectionUp) {
          onTimerTickUp();
        } else if (waveDirection == Constants.waveDirectionDown) {
          onTimerTickDown();
        }
        _timer
          ..reset()
          ..start();
        // debugPrint('tick');
      },
    )..start();
  }

  void onTimerTickUp() {
    currentMS.value += perTickMS;
    currentPercentage.value = currentMS.value / totalMS.value;

    if (currentMS.value >= totalMS.value) {
      onTimeUp();
    }
  }

  void onTimerTickDown() {
    currentMS.value -= perTickMS;
    currentPercentage.value = (currentMS.value) / totalMS.value;

    if (currentMS.value <= 0) {
      onTimeUp();
    }
  }

  void onTimerPaused() {
    debugPrint('onTimerPaused');
    if (timeUpped.value) {
      return;
    }

    _timer.pause();
    timePaused.value = true;
  }

  void onTimerContinue() {
    debugPrint('onTimerContinue');
    if (timeUpped.value) {
      return;
    }

    _timer.start();
    timePaused.value = false;
  }

  void toggleTimer() {
    if (timePaused.value) {
      onTimerContinue();
    } else {
      onTimerPaused();
    }
  }

  void onTimeUp() {
    debugPrint('onTimeUp');
    timeUpped.value = true;
    _timer.cancel();

    confettiController.value.play();
  }
}

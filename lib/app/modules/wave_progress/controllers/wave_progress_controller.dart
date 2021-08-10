import 'dart:async';

import 'package:confetti/confetti.dart';
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
  late final waveDirection;
  late final isShowPercentage;
  late final isShowTimer;
  late PausableTimer _timer;
  final confettiController =
      ConfettiController(duration: const Duration(seconds: 10)).obs;

  @override
  void onInit() {
    super.onInit();

    waveDirection =
        LocalStorage().getWaveDirection() ?? Constants.WAVE_DIRECTION_DEFAULT;
    isShowPercentage = LocalStorage().getIsShowPercentage() ??
        Constants.IS_SHOW_PERCENTAGE_DEFAULT;
    isShowPercentage =
        LocalStorage().getIsShowTimer() ?? Constants.IS_SHOW_TIMER_DEFAULT;

    int minutes = 15;
    var arg = Get.arguments;
    if (arg != null) {
      minutes = Get.arguments['selectedTimer'];
    }

    minutes = 1;

    totalMS.value = minutes * 60 * 1000 ~/ 4;

    if (waveDirection == Constants.WAVE_DIRECTION_UP) {
      currentMS.value = 0;
    } else if (waveDirection == Constants.WAVE_DIRECTION_DOWN) {
      currentMS.value = totalMS.value;
    } else {
      throw UnimplementedError();
    }

    startTimer();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _timer.cancel();
  }

  void setPercentage() {
    print('setPercentage');
  }

  void startTimer() {
    const duration = const Duration(milliseconds: perTickMS);
    // _timer = new Timer.periodic(duration, (timer) {
    _timer = PausableTimer(
      duration,
      () {
        if (waveDirection == Constants.WAVE_DIRECTION_UP) {
          onTimerTickUp();
        } else if (waveDirection == Constants.WAVE_DIRECTION_DOWN) {
          onTimerTickDown();
        }
        _timer
          ..reset()
          ..start();
        print('tick');
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
    print('onTimerPaused');
    if (timeUpped.value) {
      return;
    }

    _timer.pause();
    timePaused.value = true;
  }

  void onTimerContinue() {
    print('onTimerContinue');
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
    print('onTimeUp');
    timeUpped.value = true;
    _timer.cancel();

    confettiController.value.play();
  }
}

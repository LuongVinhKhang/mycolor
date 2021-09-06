import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mycolor/app/data_provider/local_storage.dart';

class TimerSettingController extends GetxController {
  final timerList = [0].obs;

  @override
  void onInit() {
    super.onInit();

    timerList.value = LocalStorage().getCustomTimer();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void deleteTimer(int timer) {
    final copy = [...timerList];
    copy.remove(timer);
    timerList.value = copy;

    saveToStorage();
  }

  void addTimer(int timer) {
    debugPrint("addTimer " + timer.toString());

    var copy = [...timerList];
    copy.add(timer);
    copy = copy.toSet().toList();
    copy.sort();
    timerList.value = copy;

    saveToStorage();
  }

  void saveToStorage() {
    LocalStorage().setCustomTimer(timerList);
  }
}

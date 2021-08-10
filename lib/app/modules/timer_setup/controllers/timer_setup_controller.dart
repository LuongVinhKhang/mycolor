import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mycolor/app/data/constants.dart';

class TimerSetupController extends GetxController {
  final timerList = [].obs;
  final selectedTimerShortcut = 0.obs;
  final selectedTimer = 0.obs;
  final listWheelScrolling = false.obs;

  final playpause = 'ShowPause'.obs;

  @override
  void onInit() {
    super.onInit();
    // selectedTimer.value = 15;
    List<int> me = GetStorage().read('timerList') ?? [];
    if (me.isEmpty) {
      me = Constants.DEFAULT_SHORTCUT_TIMER_MINUTES;
    }
    timerList.value = me;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void selectTimerShortcut(int timer) {
    print('selectTimerShortcut '  + timer.toString());
    selectedTimerShortcut.value = timer;
  }

  void selectTimer(int timer) {
    print('selectTimer '  + timer.toString());
    selectedTimer.value = timer;
  }
  
  void setListWheelScrolling(bool scrolling) {
    print('setListWheelScrolling ' + scrolling.toString());
    listWheelScrolling.value = scrolling;
  }
}

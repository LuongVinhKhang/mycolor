import 'package:flutter_test/flutter_test.dart';
import 'package:mycolor/app/data_provider/local_storage.dart';
import 'package:mycolor/app/modules/setting/controllers/timer_setting_controller.dart';

void main() {
  test("Aolol", () {
    TimerSettingController _timerSettingController = TimerSettingController();

    expect(_timerSettingController.timerList.length, 1);
    expect(_timerSettingController.timerList[0], 0);

    _timerSettingController.onInit();

    expect(_timerSettingController.timerList.length,
        LocalStorage().getCustomTimer().length);

    var dataFromLS = LocalStorage().getCustomTimer();
    _timerSettingController.deleteTimer(dataFromLS[0]);
    expect(_timerSettingController.timerList.length,
        LocalStorage().getCustomTimer().length);
  });
}

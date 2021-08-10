import 'package:get/get.dart';
import 'package:mycolor/app/data/constants.dart';
import 'package:mycolor/app/data_provider/local_storage.dart';

class DirectionSettingController extends GetxController {
  final directionSelected = ''.obs;

  @override
  void onInit() {
    super.onInit();

    directionSelected.value =
        LocalStorage().getWaveDirection() ?? Constants.WAVE_DIRECTION_DEFAULT;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void setDirection(String? value) {
    if (value == null) {
      directionSelected.value = 'up';
    } else {
      directionSelected.value = value;
    }

    LocalStorage().setWaveDirection(directionSelected.value);
  }
}

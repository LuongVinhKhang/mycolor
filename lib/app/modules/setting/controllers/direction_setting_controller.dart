import 'package:get/get.dart';
import 'package:mycolor/app/data_provider/local_storage.dart';

class DirectionSettingController extends GetxController {
  final directionSelected = ''.obs;

  @override
  void onInit() {
    super.onInit();
    
    directionSelected.value = LocalStorage().getWaveDirection();
    print("DirectionSettingController onInit" + directionSelected.value);
  }

  @override
  void onReady() {
    super.onReady();

    directionSelected.value = LocalStorage().getWaveDirection();
    print("DirectionSettingController onReady " + directionSelected.value);
  }

  @override
  void onClose() {
    print("colseggggggg");
    print("DirectionSettingController onClose");
  }

  void setDirection(String? value) {
    if (value == null) {
      directionSelected.value = 'up';
    } else {
      directionSelected.value = value;
    }

    LocalStorage().setWaveDirection(directionSelected.value);
  }
}

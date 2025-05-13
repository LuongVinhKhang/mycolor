import 'package:get/get.dart';
import 'package:mycolor/app/data_provider/local_storage.dart';

class WaveTextSettingController extends GetxController {
  final isShowBackButton = false.obs;
  final isShowPercentage = false.obs;
  final isShowTimer = false.obs;

  @override
  void onInit() {
    super.onInit();

    isShowBackButton.value = LocalStorage().getIsShowBackButton();
    isShowPercentage.value = LocalStorage().getIsShowPercentage();
    isShowTimer.value = LocalStorage().getIsShowTimer();
  }

  void setIsShowBackButton(bool? value) {
    if (value == null) {
      return;
    }

    isShowBackButton.value = value;
    LocalStorage().setIsShowBackButton(value: isShowBackButton.value);
  }

  void setIsShowPercentage(bool? value) {
    if (value == null) {
      return;
    }

    isShowPercentage.value = value;

    LocalStorage().setIsShowPercentage(value: isShowPercentage.value);
  }

  void setIsShowTimer(bool? value) {
    if (value == null) {
      return;
    }

    isShowTimer.value = value;
    LocalStorage().setIsShowTimer(value: isShowTimer.value);
  }
}

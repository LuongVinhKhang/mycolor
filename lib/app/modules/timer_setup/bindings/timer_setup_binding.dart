import 'package:get/get.dart';

import '../controllers/timer_setup_controller.dart';

class TimerSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimerSetupController>(
      () => TimerSetupController(),
    );
  }
}

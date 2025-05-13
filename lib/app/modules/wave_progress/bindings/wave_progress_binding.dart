import 'package:get/get.dart';

import '../controllers/wave_progress_controller.dart';

class WaveProgressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WaveProgressController>(
      () => WaveProgressController(),
    );
  }
}

import 'dart:ui';

import 'package:get/get.dart';
import 'package:mycolor/app/data/colors.dart';
import 'package:mycolor/app/data/enums.dart';
import 'package:mycolor/app/data_provider/local_storage.dart';

class ColorSettingController extends GetxController {
  final selectedColorSettingSection = ColorSettingSection.background.obs;
  final selectedSectionIndex = 0.obs;
  final selectedColorToUpdate = Color(0xFFF44336).obs;

  final dialogSeletedColor = Color(0xFFF44336).obs;

  final backgroudColors = [Color(0x00000000)].obs;
  final waveColors = [Color(0x00000000)].obs;

  final currentPercentage = 0.5.obs;

  @override
  void onInit() {
    super.onInit();
    loadColorFromStorage();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Color getLatestColorToAdd(ColorSettingSection section) {
    if (section == ColorSettingSection.background) {
      return backgroudColors.last;
    } else if (section == ColorSettingSection.wave) {
      return waveColors.last;
    }
    return Color(0xFFF44336);
  }

  void addColor(ColorSettingSection section, Color color) {
    if (section == ColorSettingSection.background) {
      final copy = [...backgroudColors];
      copy.add(color);
      backgroudColors.value = copy;
    } else if (section == ColorSettingSection.wave) {
      var copy = [...waveColors];
      copy.add(color);
      waveColors.value = copy;
    }
  }

  void reorderColorByIndex(
      ColorSettingSection section, int oldIndex, int newIndex) {
    print(
        'oldIndex ' + oldIndex.toString() + ' newIndex ' + newIndex.toString());
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    if (section == ColorSettingSection.background) {
      final copy = [...backgroudColors];
      final element = copy.removeAt(oldIndex);
      copy.insert(newIndex, element);
      backgroudColors.value = copy;
    } else if (section == ColorSettingSection.wave) {
      var copy = [...waveColors];
      final element = copy.removeAt(oldIndex);
      copy.insert(newIndex, element);
      waveColors.value = copy;
    }
  }

  void removeColorByIndex(ColorSettingSection section, int index) {
    if (section == ColorSettingSection.background) {
      var copy = [...backgroudColors];
      copy.removeAt(index);
      backgroudColors.value = copy;
    } else if (section == ColorSettingSection.wave) {
      var copy = [...waveColors];
      copy.removeAt(index);
      waveColors.value = copy;
    }
  }

  void setColor(Color color) {
    if (selectedColorSettingSection.value == ColorSettingSection.background) {
      var copy = [...backgroudColors];
      copy[selectedSectionIndex.value] = color;
      backgroudColors.value = copy;
    } else if (selectedColorSettingSection.value == ColorSettingSection.wave) {
      var copy = [...waveColors];
      copy[selectedSectionIndex.value] = color;
      waveColors.value = copy;
    }
  }

  void resetColorList(ColorSettingSection section) {
    if (section == ColorSettingSection.background) {
      backgroudColors.value = ColorConstants.DEFAULT_BACKGROUND_COLOR;
    } else if (section == ColorSettingSection.wave) {
      waveColors.value = ColorConstants.DEFAULT_WAVE_COLOR;
    }
  }

  // ----------------- storage
  void loadColorFromStorage() {
    print('loadColorFromStorage');
    backgroudColors.value = LocalStorage().getBackgroundColors() ??
        ColorConstants.DEFAULT_BACKGROUND_COLOR;
    waveColors.value =
        LocalStorage().getWaveColors() ?? ColorConstants.DEFAULT_WAVE_COLOR;
  }

  void saveColorToStorage() {
    print('saveColorToStorage');
    LocalStorage().setBackgroundColors(backgroudColors);
    LocalStorage().setWaveColors(waveColors);
  }
}

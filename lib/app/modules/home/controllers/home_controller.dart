import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mycolor/app/data/enums.dart';
import 'package:mycolor/app/data_provider/local_storage.dart';
import 'package:mycolor/app/theme/app_themes.dart';

class HomeController extends GetxController {
  late GlobalKey<FormState> formKey;
  late TextEditingController mobileNumberEditingController;
  bool isFormValid = false;

  late final GetStorage _getStorage;
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));
    mobileNumberEditingController = TextEditingController();
    formKey = GlobalKey<FormState>();
    _getStorage = GetStorage();
    isDarkMode.value = _getStorage.read(StorageKeys.isDarkMode);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    mobileNumberEditingController.dispose();
  }

  String? validateMobile(String value) {
    if (value.length < 10) {
      return "Provide valid mobile number";
    }
    return null;
  }

  void validateAndCheckMobileNumber(String mobileNumber) {
    isFormValid = formKey.currentState!.validate();
    if (!isFormValid) {
      return;
    } else {
      formKey.currentState!.save();
    }
  }

  void changeTheme(BuildContext context) {
    var newTheme = AppThemes.darkThemeData;

    if (isDarkMode.value) {
      print('change from dark to light');
      newTheme = AppThemes.lightThemeData;
      ThemeSwitcher.of(context)!
          .changeTheme(theme: newTheme, reverseAnimation: false);
    } else {
      print('change from light to dark');
      ThemeSwitcher.of(context)!
          .changeTheme(theme: newTheme, reverseAnimation: true);
    }

    isDarkMode.value = !isDarkMode.value;
    LocalStorage().setDarkMode(isDarkMode.value);
    print('homec ' +
        Get.isDarkMode.toString() +
        ' ' +
        Get.isPlatformDarkMode.toString() +
        ' ' +
        LocalStorage().isDarkMode().toString());
  }
}

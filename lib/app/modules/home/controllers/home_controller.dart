import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late GlobalKey<FormState> formKey;
  late TextEditingController mobileNumberEditingController;
  bool isFormValid = false;

  @override
  void onInit() {
    super.onInit();
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));
    mobileNumberEditingController = TextEditingController();
    formKey = GlobalKey<FormState>();
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
      return 'Provide valid mobile number';
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
}

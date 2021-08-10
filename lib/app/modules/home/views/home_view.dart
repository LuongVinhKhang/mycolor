import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mycolor/app/data/colors.dart';
import 'package:mycolor/app/data/constants.dart';
import 'package:mycolor/app/data/custom_theme.dart';
import 'package:mycolor/app/data/enums.dart';
import 'package:mycolor/app/data_provider/local_storage.dart';
import 'package:mycolor/app/global_widgets/cat_view.dart';
import 'package:mycolor/app/routes/app_pages.dart';
import 'package:mycolor/app/theme/app_colors.dart';
import 'package:mycolor/app/theme/app_text_styles.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    ThemeSwitchingArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: ThemeSwitcher(
              builder: (context) => Obx(() => IconButton(
                    icon: controller.isDarkMode.value
                        ? Icon(
                            CupertinoIcons.brightness,
                            color: Colors.white,
                          )
                        : Icon(
                            CupertinoIcons.moon_stars,
                            color: Colors.black,
                          ),
                    onPressed: () {
                      controller.changeTheme(context);
                    },
                  ))),
          actions: [],
        ),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTopImage(),
                    SizedBox(
                      height: 20,
                    ),
                    _buildText(
                        data: "Enter Mobile Number to Register/Login",
                        textStyle:
                            AppTextStyles().kTextStyleFourteenWithThemeColor),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          _buildTextFormField(),
                          SizedBox(
                            height: 16,
                          ),
                          _buildElevatedButton(context),
                          SizedBox(
                            height: 16,
                          ),
                          _buildText(
                              data:
                                  "We will send OTP message for unregistered user",
                              textStyle: AppTextStyles()
                                  .kTextStyleTwelveWithGreyColor),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: _buildFooter(),
            )
          ],
        ),
      ),
    );
    return ThemeSwitchingArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // backgroundColor: Theme.of(context).colorScheme.background,
          title: Text('HomeView'),
          centerTitle: true,
          leading: ThemeSwitcher(
              builder: (context) => Obx(() => IconButton(
                    icon: controller.isDarkMode.value
                        ? Icon(
                            CupertinoIcons.brightness,
                          )
                        : Icon(
                            CupertinoIcons.moon_stars,
                          ),
                    onPressed: () {
                      controller.changeTheme(context);
                    },
                  ))),
          actions: [
            IconButton(
                onPressed: () {
                  // Get.toNamed(Routes.SETTING);
                  Get.toNamed(Routes.SETTING);
                },
                icon: Icon(Icons.settings))
          ],
        ),
        // appBar: CupertinoNavigationBar(
        //   // backgroundColor: Theme.of(context).colorScheme.background,
        //   middle: Text('HomeView'),
        //   // centerTitle: true,
        //   leading: ThemeSwitcher(
        //       builder: (context) => Obx(() => IconButton(
        //             icon: controller.isDarkMode.value
        //                 ? Icon(
        //                     CupertinoIcons.brightness,
        //                     // color: Colors.white,
        //                   )
        //                 : Icon(
        //                     CupertinoIcons.moon_stars,
        //                     // color: Colors.black,
        //                   ),
        //             onPressed: () {
        //               controller.changeTheme(context);
        //             },
        //           ))),
        //   trailing:
        //     IconButton(
        //         onPressed: () {
        //           Get.toNamed(Routes.SETTING);
        //         },
        //         icon: Icon(Icons.settings))
        //   ,
        // ),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.ac_unit_outlined)),
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.TIMER_SETUP);
                },
                child: Text(
                  'HomeView is working',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.WAVE_PROGRESS);
                },
                child: Text(
                  'Drinking',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () {
                  GetStorage().erase();
                },
                child: Text(
                  'Reset storage 3',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () {
                  LocalStorage()
                      .setBackgroundColors(ColorConstants.DEFAULT_WAVE_COLOR);
                },
                child: Text(
                  'save storage 3',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () {
                  print(GetStorage().getKeys().toString());
                  print(GetStorage().getValues().toString());
                },
                child: Text(
                  'Get storage 3',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              // Wrap(children: [_buildFooter()],)
            ],
          ),
        )),
      ),
    );
  }

  _buildFooter() {
    return CatView(
      catState: "Sit",
    );
  }

  Widget _buildTopImage() {
    return Image.asset(
      'assets/images/1_No Connection.png',
      height: 150,
      width: 150,
    );
  }

  Widget _buildText({required String data, required TextStyle textStyle}) {
    return Text(
      data,
      style: textStyle,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTextFormField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (val) {
        controller.validateAndCheckMobileNumber(val);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller.mobileNumberEditingController,
      style: AppTextStyles().kTextStyleWithFont,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: "Mobile Number",
        hintStyle: AppTextStyles().kTextStyleWithFont,
        labelText: "Mobile Number",
        labelStyle: AppTextStyles().kTextStyleWithFont,
        prefixIcon: Icon(Icons.phone),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        isDense: true,
        errorStyle: AppTextStyles().kTextStyleWithFont,
      ),
      maxLength: 10,
      validator: (value) {
        return controller.validateMobile(value!);
      },
    );
  }

  Widget _buildElevatedButton(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: context.width),
      child: ElevatedButton(
        onPressed: () {
          controller.validateAndCheckMobileNumber(
              controller.mobileNumberEditingController.text);
        },
        child: Text(
          "Continue",
          style: AppTextStyles().kTextStyleWithFont,
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            elevation: 10,
            padding: EdgeInsets.all(14)),
      ),
    );
  }
}

Widget _buildFooter() {
  return ClipPath(
    clipper: FooterWaveClipper(),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: AppColors().bottomFooterGradient,
            begin: Alignment.center,
            end: Alignment.bottomRight),
      ),
      height: Get.height / 3,
    ),
  );
}

class FooterWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height - 100);
    // var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    // var secondEndPoint = Offset(size.width, 0.0);
    // path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
    //     secondEndPoint.dx, secondEndPoint.dy);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

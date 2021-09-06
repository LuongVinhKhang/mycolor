import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mycolor/app/routes/app_pages.dart';
import 'package:mycolor/app/theme/app_colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.ac_unit_outlined)),
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
              // Wrap(children: [_buildFooter()],)
            ],
          ),
        )),
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

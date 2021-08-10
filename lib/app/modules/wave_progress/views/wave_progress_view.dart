import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:get/get.dart';
import 'package:mycolor/app/data/colors.dart';
import 'package:mycolor/app/global_widgets/liquid_linear_progress_indicator.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../controllers/wave_progress_controller.dart';

class WaveProgressView extends GetView<WaveProgressController> {
  _buildPercentage() {
    return Obx(() => Text(
          (controller.currentPercentage * 100).toInt().toString() + '%',
          style: TextStyle(fontSize: 30),
        ));
  }

  _buildTimer() {
    return Obx(() => Text(
          (controller.currentMS / 1000).toInt().toString() +
              '/' +
              (controller.totalMS / 1000).toInt().toString(),
          style: TextStyle(fontSize: 30),
        ));
  }

  _buildWave() {
    return Obx(() => LiquidLinearProgressIndicator(
          value: controller.currentPercentage.value,
          colors: ColorConstants.DEFAULT_WAVE_COLOR,
          backgroundColors: ColorConstants.DEFAULT_BACKGROUND_COLOR,
          direction: Axis.vertical,
        ));
  }

  _buildTextYouDidIt() {
    return SizedBox(
      width: 250.0,
      height: 50,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 35,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 7.0,
              color: Colors.white,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            FlickerAnimatedText("You did it!"),
          ],
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }

  _buildTextCongrats() {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 45.0,
      fontFamily: 'Horizon',
    );

    return SizedBox(
      width: 250.0,
      height: 80,
      child: AnimatedTextKit(
        stopPauseOnTap: true,
        repeatForever: true,
        animatedTexts: [
          ColorizeAnimatedText(
            'CONGRATS',
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          )
        ],
        isRepeatingAnimation: true,
        onTap: () {
          print("Tap Event");
          controller.confettiController.value.play();
        },
      ),
    );
  }

  _buildTextes() {
    return Obx(() => controller.timeUpped.value
        ? Wrap(
            children: [_buildTextCongrats(), _buildTextYouDidIt()],
          )
        : Container());
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  _buildConfetti() {
    return Obx(() => controller.timeUpped.value
        ? ConfettiWidget(
            confettiController: controller.confettiController.value,
            blastDirectionality: BlastDirectionality
                .explosive, // don't specify a direction, blast randomly
            shouldLoop:
                true, // start again as soon as the animation is finished
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // manually specify the colors to be used
            createParticlePath: drawStar, // define a custom shape/path.
          )
        : Container());
  }

  _buildPercentageAndTimer() {
    return Wrap(
      children: [
        controller.isShowPercentage ? _buildPercentage() : Container(),
        controller.isShowTimer ? _buildTimer() : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildWave(),
          Align(
            alignment: Alignment.center,
            child: _buildPercentageAndTimer(),
          ),
          Align(
            alignment: Alignment.center,
            child: _buildConfetti(),
          ),
          Align(alignment: Alignment.center, child: _buildTextes()),
          GestureDetector(
            onDoubleTap: () {
              controller.onTimerPaused();
            },
            onTap: () {
              controller.onTimerContinue();
            },
          )
        ],
      ),
    );
  }
}

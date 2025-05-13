import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycolor/app/global_widgets/liquid_linear_progress_indicator.dart';

import '../controllers/wave_progress_controller.dart';

class WaveProgressView extends GetView<WaveProgressController> {
  static const List<Shadow>? textShadow = <Shadow>[
    Shadow(
      blurRadius: 20,
    ),
  ];

  static const percentageTextStyle =
      TextStyle(fontSize: 30, shadows: textShadow);

  static const timerTextStyle = TextStyle(fontSize: 30, shadows: textShadow);

  Widget _buildBackButton() {
    return const SafeArea(child: BackButton());
  }

  Widget _buildPercentage() {
    return Obx(() => Text('${(controller.currentPercentage * 100).toInt()}%',
        style: percentageTextStyle));
  }

  Widget _buildTimer() {
    return Obx(() => Text(
          '${(controller.currentMS / 1000).toInt()}/${(controller.totalMS / 1000).toInt()}',
          style: timerTextStyle,
        ));
  }

  Widget _buildPercentageAndTimer() {
    return Obx(() => !controller.timeUpped.value
        ? Wrap(
            direction: Axis.vertical,
            children: [
              if (controller.isShowPercentage)
                _buildPercentage()
              else
                const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              if (controller.isShowTimer) _buildTimer() else const SizedBox(),
            ],
          )
        : Container());
  }

  Widget _buildWave() {
    return Obx(() => LiquidLinearProgressIndicator(
          value: controller.currentPercentage.value,
          colors: controller.waveColors,
          backgroundColors: controller.backgroudColors,
          direction: Axis.vertical,
        ));
  }

  Widget _buildTextYouDidIt() {
    return SizedBox(
      width: 250,
      height: 50,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 35,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 7,
              color: Colors.white,
              offset: Offset(1, 0),
            ),
          ],
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            FlickerAnimatedText('You did it!'),
          ],
          onTap: () {
            debugPrint('Tap Event');
          },
        ),
      ),
    );
  }

  Widget _buildTextCongrats() {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 45,
      fontFamily: 'Horizon',
    );

    return SizedBox(
      width: 250,
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
        onTap: () {
          debugPrint('Tap Event');
          controller.confettiController.value.play();
        },
      ),
    );
  }

  Widget _buildTextes() {
    return Obx(() => controller.timeUpped.value
        ? Wrap(
            direction: Axis.vertical,
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

    for (var step = 0.0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  Widget _buildConfetti() {
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

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        body: Stack(
          children: [
            _buildWave(),
            Align(
              child: _buildPercentageAndTimer(),
            ),
            Align(
              child: _buildConfetti(),
            ),
            Align(child: _buildTextes()),
            GestureDetector(
              onDoubleTap: () {
                controller.onTimerPaused();
              },
              onTap: () {
                controller.onTimerContinue();
              },
            ),
            Align(
              alignment: Alignment.topLeft,
              child: _buildBackButton(),
            )
          ],
        ),
      ),
    );
  }
}

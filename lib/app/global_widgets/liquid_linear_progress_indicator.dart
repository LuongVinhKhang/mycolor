import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'wave.dart';

class LiquidLinearProgressIndicator extends ProgressIndicator {
  LiquidLinearProgressIndicator({
    Key? key,
    required double value,
    required this.backgroundColors,
    required this.colors,
    this.direction = Axis.horizontal,
  }) : super(key: key, value: value) {
    debugPrint('rebuild wave $value');
    // debugPrint(colors.toString());
    // debugPrint(backgroundColors.toString());
  }

  final Axis direction;
  final List<Color> colors;
  final List<Color> backgroundColors;

  @override
  State<StatefulWidget> createState() => _LiquidLinearProgressIndicatorState();
}

class _LiquidLinearProgressIndicatorState
    extends State<LiquidLinearProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key ?? ObjectKey(widget.backgroundColors),
      // key: ValueKey(widget.value.toString() +
      //     widget.colors.toString() +
      //     widget.backgroundColors.toString()),
      decoration: widget.backgroundColors.length == 1
          ? BoxDecoration(
              color: widget.backgroundColors.first,
              // borderRadius: BorderRadius.circular(10),
            )
          : BoxDecoration(
              // borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: widget.backgroundColors)),
      child: widget.value == 0
          ? Container()
          : Stack(
              children: widget.colors
                  .asMap()
                  .map((index, e) => MapEntry(
                      index,
                      Wave(
                          value: widget.value!,
                          color: e,
                          direction: widget.direction,
                          index: index)))
                  .values
                  .toList()),
    );
  }
}

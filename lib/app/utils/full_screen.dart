import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// From https://github.com/Athanax/fullscreen/blob/master/lib/fullscreen.dart
class FullScreen {
  // meothod channel instal
  static const MethodChannel _channel = const MethodChannel('fullscreen');

  /// To enable fullscreen mode, pass the fullscreen mode as an argument the the enterFullScreen method of the FullScreen class.
  static Future<void> enterFullScreen(FullScreenMode fullScreenMode) async {
    if (Platform.isIOS) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else if (Platform.isAndroid) {
      try {
        if (fullScreenMode == FullScreenMode.EMERSIVE) {
          await _channel.invokeMethod('emersive');
        } else if (fullScreenMode == FullScreenMode.EMERSIVE_STICKY) {
          await _channel.invokeMethod('emersiveSticky');
        } else if (fullScreenMode == FullScreenMode.LEANBACK) {
          await _channel.invokeMethod('leanBack');
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  /// to get the current status of the SystemUI
  static Future<bool?> get isFullScreen async {
    bool? status;
    try {
      status = await _channel.invokeMethod("status");
    } catch (e) {
      debugPrint(e.toString());
    }
    return status;
  }

  /// Exit full screen
  static Future<void> exitFullScreen() async {
    if (Platform.isIOS) {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    } else if (Platform.isAndroid) {
      try {
        await _channel.invokeMethod('exitFullScreen');
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }
}

// ignore: constant_identifier_names
enum FullScreenMode { NONE, EMERSIVE, EMERSIVE_STICKY, LEANBACK }

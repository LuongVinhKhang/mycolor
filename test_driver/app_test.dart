import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("description", () {
    late FlutterDriver driver;

    Future<FlutterDriver> setupAndGetDriver() async {
      FlutterDriver driver = await FlutterDriver.connect();
      var connected = false;
      while (!connected) {
        try {
          await driver.waitUntilFirstFrameRasterized();
          connected = true;
        } catch (error) {}
      }
      return driver;
    }

    setUpAll(() async {
      // driver = await FlutterDriver.connect();

      driver = await setupAndGetDriver();
      // await sleep(Duration(seconds: 10));
    });

    tearDownAll(() async {
      driver.close();
    });

    test("da", () async {
      final btnDark = find.byValueKey("TimerSetupView/AppBar/Icon/Dark");
      final btnLight = find.byValueKey("TimerSetupView/AppBar/Icon/Light");
      final themeSwitcher = find.byValueKey("ThemeSwitcher");

      await driver.tap(themeSwitcher);
      // // Then, verify the counter text is incremented by 1.
      // expect(await driver.getText(counterTextFinder), "1");
    });
  });
}

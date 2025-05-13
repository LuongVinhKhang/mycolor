import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mycolor/app/modules/timer_setup/views/timer_setup_view.dart';

void main() {
  testWidgets("Allodsa", (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: ThemeProvider(
        child: TimerSetupView(),
      ),
    ));

    // await widgetTester.pumpWidget(MaterialApp(
    //   home: TimerSetupView(),
    // ));

    final themeSwitcher = find.byKey(ValueKey("ThemeSwitcher"));
    // final themeSwitcher = find.byElementType(ThemeSwitcher);
    // final themeSwitcher = find.byIcon(CupertinoIcons.moon_stars);

    await widgetTester.tap(themeSwitcher);
    await widgetTester.pump(Duration(seconds: 2));

    expect(
        find.byIcon(
          CupertinoIcons.brightness,
        ),
        findsOneWidget);
  });
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mycolor/app/data_provider/local_storage.dart';

class AppColors {
  var bottomFooterGradient = LocalStorage().isDarkMode()
      ? [
          Colors.lightBlue,
          Colors.lightBlue.shade100,
        ]
      : [
          Color(0xFF6200EE),
          Colors.deepPurple.shade300,
        ];

  var kPrimaryTextColor =
      LocalStorage().isDarkMode() ? Color(0xDDFFFFFF) : Color(0xDD000000);
  var kSecondaryTextColor =
      LocalStorage().isDarkMode() ? Color(0x89FFFFFF) : Color(0x89000000);
}

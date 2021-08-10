import 'package:mycolor/app/utils/full_screen.dart';

class Constants {
  static const NONE_FULL_SCREEN_MODE = 'NONE';

  static const FULL_SCREEN_MODE_ANDROID = {
    'LEANBACK': FullScreenMode.LEANBACK,
    'EMERSIVE': FullScreenMode.EMERSIVE,
    'EMERSIVE_STICKY': FullScreenMode.EMERSIVE_STICKY,
    'NONE': 'NONE'
  };

  static const FULL_SCREEN_MODE_IOS = {
    'FULL_SCREEN': FullScreenMode.LEANBACK,
    'NONE': 'NONE'
  };

  static const WAVE_DIRECTION_DEFAULT = 'UP';
  static const WAVE_DIRECTION_UP = 'UP';
  static const WAVE_DIRECTION_DOWN = 'DOWN';
  static const IS_SHOW_PERCENTAGE_DEFAULT = true;
  static const IS_SHOW_TIMER_DEFAULT = false;

  static const THE_MOVIE_DB_API_KEY = 'TU_API_KEY';
  static const THE_MOVIE_DB_IMG_PATH = 'https://image.tmdb.org/t/p/original';
  static const DEFAULT_SHORTCUT_TIMER_MINUTES = [15, 30, 45, 60];
  static const TIMER_MINUTES = [
    5,
    10,
    15,
    20,
    25,
    30,
    35,
    40,
    45,
    50,
    55,
    60,
    70,
    80,
    90,
    100,
    110,
    120,
    130,
    140,
    150,
    160,
    170,
    180
  ];
}

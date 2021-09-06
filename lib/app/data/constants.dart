import 'package:mycolor/app/utils/full_screen.dart';

class Constants {
  static const noneFullScreenMode = 'NONE';

  static const fullScreenModeAndroid = {
    'LEANBACK': FullScreenMode.LEANBACK,
    'EMERSIVE': FullScreenMode.EMERSIVE,
    'EMERSIVE_STICKY': FullScreenMode.EMERSIVE_STICKY,
    'NONE': FullScreenMode.NONE
  };

  static const fullScreenModeIos = {
    'FULL_SCREEN': FullScreenMode.LEANBACK,
    'NONE': FullScreenMode.NONE
  };

  static const languageDefault = 'en';
  static const isDarkModeDefault = false;
  static const waveDirectionDefault = 'UP';
  static const waveDirectionUp = 'UP';
  static const waveDirectionDown = 'DOWN';

  static const isShowBackButtonDefault = true;
  static const isShowPercentageDefault = true;
  static const isShowTimerDefault = false;

  static const theMovieDbApiKey = 'TU_API_KEY';
  static const theMovieDbImgPath = 'https://image.tmdb.org/t/p/original';
  static const defaultShortcutTimerMinutes = [15, 30, 45, 60];
  static const timerMinutes = [
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

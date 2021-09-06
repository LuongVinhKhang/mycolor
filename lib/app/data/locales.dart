import 'dart:ui';

Map<String, Locale> SUPPORTED_LOCALES_MAP = const {
  // 'system':  Locale('en'),
  // 'en': Locale('en'),
  // 'ar': Locale('ar'),
  // 'zh_CN': Locale('zh', 'CN'),
  // 'zh_TW': Locale('zh', 'TW')
  // 'he thong': Locale('en'),
  'English': Locale('en'),
  'عربى': Locale('ar'),
  '简体中文': Locale('zh', 'CN'),
  '繁體中文': Locale('zh', 'TW')
};

// Locale system_locale = Locale('en');
// final String SYSTEM_LOCALE_KEY = 'system';
final Locale FALLBACK_LOCALE = const Locale('en');

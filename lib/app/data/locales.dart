import 'dart:ui';

Map<String, Locale> SUPPORTED_LOCALES_MAP = const {
  // 'system':  Locale('en'),
  // 'en': Locale('en'),
  // 'ar': Locale('ar'),
  // 'zh_CN': Locale('zh', 'CN'),
  // 'zh_TW': Locale('zh', 'TW')
  'he thong':  Locale('en'),
  'tieng anh': Locale('en'),
  'Ả Rập': Locale('ar'),
  'TQ giản': Locale('zh', 'CN'),
  'TQ_phồn' : Locale('zh', 'TW')
};

final String SYSTEM_LOCALE_KEY = 'system';
Locale system_locale = Locale('en');

final Locale FALLBACK_LOCALE = const Locale('en');
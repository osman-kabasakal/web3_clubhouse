import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocations {
  final Locale locale;
  AppLocations({required this.locale});

  static AppLocations? of(BuildContext context) {
    return Localizations.of<AppLocations>(context, AppLocations);
  }

  static const LocalizationsDelegate<AppLocations> delegate =
      _AppLocalizationDelegate();

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    String jsonString = await rootBundle
        .loadString("assets/i18n/${locale.languageCode}.json")
        .catchError((_) => rootBundle.loadString("assets/i18n/tr.json"));
    Map<String, dynamic> jsonMap =
        Map<String, dynamic>.from(jsonDecode(jsonString));
    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  String translate(String key) {
    if (_localizedStrings != null && _localizedStrings.containsKey(key)) {
      if(_localizedStrings[key] == null) {
        return key;
      }

      return _localizedStrings[key]!;
    }
    return "";
  }
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocations> {
  const _AppLocalizationDelegate();

  @override
  bool shouldReload(LocalizationsDelegate<AppLocations> old) {
    return false;
  }

  @override
  bool isSupported(Locale locale) {
    return true;
    // ['tr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocations> load(Locale locale) async {
    AppLocations localizations = AppLocations(locale: locale);
    await localizations.load();
    return localizations;
  }
}

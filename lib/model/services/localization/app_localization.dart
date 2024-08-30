// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:ui' as ui;
import '../core_helper/preference.dart';




class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale(ui.window.locale.languageCode);
  Locale get appLocale => _appLocale;

  AppLanguage() {
    fetchLocale();
  }

  String languageName = "English";

  void fetchLocale() async {
    if (Preference.getString(PrefKeys.languageCode) == null) {
      _appLocale = Locale(ui.window.locale.languageCode);

    } else {
      if (Preference.getString(PrefKeys.languageCode) == "en") {
        languageName = "English";
      } else {
        languageName = "العَرَبِيَّة";
      }
      _appLocale = Locale(Preference.getString(PrefKeys.languageCode)!);
    }
    notifyListeners();
  }

  void changeLanguage(Locale locale) async {
    if (_appLocale != locale) {
      if (locale == const Locale("en")) {
        _appLocale = const Locale("en");
        languageName = "English";
        await Preference.setString(PrefKeys.languageCode, "en");
      } else {
        _appLocale = const Locale("ar");
        languageName = "العَرَبِيَّة";
        await Preference.setString(PrefKeys.languageCode, "ar");
      }
      notifyListeners();
    }
  }
}

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  /// Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  /// Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  late Map<String, String> _localizedMap;

  Future<bool> load() async {
    /// Load the language JSON file from the "lang" folder
    String jsonString = await rootBundle.loadString("lib/model/services/localization/${locale.languageCode}.json");
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedMap = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  String get(String key) {
    return _localizedMap[key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return ["en", "ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) {
    return false;
  }
}

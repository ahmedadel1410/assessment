// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:ui' as ui;
import '../core_helper/preference.dart';




import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:ui' as ui;
import '../core_helper/preference.dart';

class AppLanguageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeLanguageEvent extends AppLanguageEvent {
  final Locale locale;

  ChangeLanguageEvent(this.locale);

  @override
  List<Object?> get props => [locale];
}

class AppLanguageState extends Equatable {
  final Locale locale;
  final String languageName;

  const AppLanguageState(this.locale, this.languageName);

  @override
  List<Object?> get props => [locale, languageName];
}

class AppLanguageBloc extends Bloc<AppLanguageEvent, AppLanguageState> {
  AppLanguageBloc()
      : super(AppLanguageState(
    Locale(ui.window.locale.languageCode),
    ui.window.locale.languageCode == "ar" ? "العَرَبِيَّة" : "English",
  )) {
    on<ChangeLanguageEvent>(_onChangeLanguage);
    _fetchLocale();
  }

  void _onChangeLanguage(ChangeLanguageEvent event, Emitter<AppLanguageState> emit) async {
    Locale newLocale = event.locale;
    String languageName = newLocale.languageCode == "ar" ? "العَرَبِيَّة" : "English";

    await Preference.setString(PrefKeys.languageCode, newLocale.languageCode);
    emit(AppLanguageState(newLocale, languageName));
  }

  void _fetchLocale() async {
    String? languageCode = Preference.getString(PrefKeys.languageCode);
    if (languageCode != null) {
      add(ChangeLanguageEvent(Locale(languageCode)));
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

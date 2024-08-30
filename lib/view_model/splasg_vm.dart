import 'package:flutter/material.dart';
import '../model/services/base/base_model.dart';
import '../model/services/localization/app_localization.dart';

class SplashPageModel extends BaseModel {
  final BuildContext context;
  late AppLocalizations locale;


  SplashPageModel({required this.context}) {
    locale = AppLocalizations.of(context);
    delayFun();
  }
  delayFun() async {
    Future.delayed(const Duration(milliseconds: 500), () {

    });
  }
}
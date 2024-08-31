import 'package:flutter/material.dart';
import '../model/services/base/base_model.dart';
import '../model/services/localization/app_localization.dart';
import '../view/pages/home/home.dart';

class SplashPageModel extends BaseModel {
  final BuildContext context;
  late AppLocalizations locale;


  SplashPageModel({required this.context}) {
    locale = AppLocalizations.of(context);
    delayFun();
  }
  delayFun() async {
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Home()));

    });
  }
}
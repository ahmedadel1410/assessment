

import 'package:flutter/cupertino.dart';

import '../model/services/base/base_model.dart';
import '../model/services/localization/app_localization.dart';

class HomeModel extends BaseModel {

  final BuildContext context;
  late AppLocalizations locale;


  HomeModel({required this.context}) {
    locale = AppLocalizations.of(context);
  }


}
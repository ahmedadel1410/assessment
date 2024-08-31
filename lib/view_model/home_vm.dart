

import 'package:flutter/cupertino.dart';

import '../model/services/base/base_model.dart';
import '../model/services/localization/app_localization.dart';

class HomeModel extends BaseModel {

  final BuildContext context;
  late AppLocalizations locale;

  String? selectedCountryFrom;
  String? selectedCountryTo;
  List<String> countries=["egypt","qatar","south" ,"arabia","sudan"];
  List<String>  classes=["First","Economy","Premium", "Business"];
  List<String>  travels=["1 adult","2 adults","3 adults" ,"4 adults","5 adults"];
  String? selectedTravels;
  String? selectedClass;

  DateTime? selectedDayFrom;
  DateTime? selectedDayTo;
  String? formattedFrom;
  String? formattedTo;

  HomeModel({required this.context}) {
    locale = AppLocalizations.of(context);
  }






  set (String formattedFrom) {}



 getContries(){

   }

}
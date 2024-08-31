import 'package:assessment/view/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../model/models/user.dart';
import '../model/services/base/base_model.dart';
import '../model/services/localization/app_localization.dart';
import '../model/services/provider/provider_setup.dart';

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
  List<User> users=[];
  HomeModel({required this.context}) {
    locale = AppLocalizations.of(context);
  }









 getUsers() async {
   setBusy();
   final res = await api.getUsers(context);
  for(var e in res){
    User user=User.fromJson(e);
    users.add(user);
  }
  showDialog(context: context, builder: (context){
   return  Dialog(
     child: Container(
       padding: const EdgeInsets.all(16),
       alignment: Alignment.center,
       decoration: BoxDecoration(
         color: AppColors.primaryColor,
         borderRadius: BorderRadius.circular(16),
         
       ),
       height: 200,
       width: 200,
       child: const Text("100 user fetched check home_vm",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 22),),
     ),

   );

  },
    barrierDismissible: false
  );
   Future.delayed(const Duration(seconds: 2),(){
Navigator.of(context).pop();
   });
   setIdle() ;
 }

}
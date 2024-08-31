// ignore_for_file: file_names
import 'package:assessment/model/services/core_helper/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../model/services/base/base_widget.dart';
import '../../view_model/home_vm.dart';
import '../styles/app_colors.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    return BaseWidget<HomeModel>(
      model: HomeModel(context: context),
      initState: (model){
      },
      builder: (_, model, child) {

        return DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: AppColors.background,
            body:RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: ()async{},
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: SizeConfig.height*.06,bottom: SizeConfig.height*.07),
                    height: SizeConfig.height*.4,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage("images/worldMapVector.png"),),
                        borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20) ,bottomRight:Radius.circular(20) ),
                        color: AppColors.primaryColor,
                    ),
                    child: Column(
                      children: [
                        Image.asset("images/logo.png",width: double.maxFinite,height: 28,),
                        Image.asset("images/flightVector.png",height: SizeConfig.height*.17,),
                         const Expanded(child: SizedBox()),
                         TabBar(
                           indicatorSize: TabBarIndicatorSize.label,
                           unselectedLabelStyle: TextStyle(color: Colors.white.withOpacity(.5)),
                           labelStyle: const TextStyle(color: Colors.white),
                           indicatorColor: Colors.white,
                           dividerColor: Colors.white.withOpacity(0),
                            indicatorPadding: const EdgeInsets.only(right: 40),


                           tabs: [
                             const Text("Round Trip"),
                             const Text("One-Way"),
                             const Text("Multi City"),
                           ],
                         ),

                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.height*.35,left: 22,right: 22),
                    alignment: Alignment.bottomCenter,
                    height: SizeConfig.height*.43,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: ListView(
                      padding: const EdgeInsets.only(left: 16,top: 30,right: 16),
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 6),
                          width: SizeConfig.width*.4,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                            Border.all(color:AppColors.formFill2),
                            color: AppColors.formFill,
                          ),
                          child: Row(
                            children: [
                              (model.selectedCountryFrom ==null)?  Container():  SvgPicture.asset("images/svgs/Ellipse 219.svg",height: 13,width: 15,),
                              SizedBox(width:5,),
                              Expanded(
                                child: DropdownButton<String>(
                                    style: TextStyle(color: AppColors.primaryColor),
                                  value: model.selectedCountryFrom,
                                  icon: (model.selectedCountryFrom==null)?Container():
                                  Text("(${model.selectedCountryFrom!.substring(0, 3)})",style: TextStyle(color: AppColors.formFill2.withOpacity(.38)),),
                                  elevation: 16,
                                  underline: Container(),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    model.selectedCountryFrom = value!;
                                    model.setState();
                                  },
                                  items: model.countries
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),


                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          padding: const EdgeInsets.only(left: 6),

                          width: SizeConfig.width*.4,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                            Border.all(color:AppColors.formFill2),
                            color: AppColors.formFill,
                          ),
                          child: Row(
                            children: [
                              (model.selectedCountryTo ==null)?  Container():  SvgPicture.asset("images/svgs/Vector.svg",height: 13,width: 15,),
                              SizedBox(width:5,),
                              Expanded(
                                child: DropdownButton<String>(
                                  style: TextStyle(color: AppColors.primaryColor),

                                  value: model.selectedCountryTo,
                                  icon: (model.selectedCountryTo==null)?Container():
                                  Text("(${model.selectedCountryTo!.substring(0, 3)})",style: TextStyle(color: AppColors.formFill2.withOpacity(.38)),),
                                  elevation: 16,
                                  underline: Container(),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    model.selectedCountryTo = value!;
                                    model.setState();
                                  },
                                  items: model.countries
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),


                            ],
                          ),
                        ),
                        const SizedBox(height: 16,),

                        GestureDetector(
                          onTap: (){
                            showDialog(context: context, builder: (context){
                              return Dialog(
                                child:  Container(
                                  padding: const EdgeInsets.all(16),
                                  height:SizeConfig.height*.5,
                                  width:SizeConfig.width*.8,
                                  decoration: BoxDecoration(
                                      color: Colors.white,

                                      borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color:AppColors.formFill2)
                                  ),
                                  child: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {

                               return TableCalendar(
                                 rangeSelectionMode: RangeSelectionMode.toggledOn,
                                 firstDay: DateTime.utc(2010, 10, 16),
                                 lastDay: DateTime.utc(2030, 3, 14),
                                 focusedDay: model.selectedDayFrom ?? DateTime.now(),
                                 rangeStartDay: model.selectedDayFrom,
                                 rangeEndDay: model.selectedDayTo,
                                 onRangeSelected: (from, to, x) {
                                   model.selectedDayFrom = from;
                                   model.selectedDayTo = to;

                                   final DateFormat formatter = DateFormat('d, MMM yyyy');
                                   if(to !=null){
                                     model. formattedFrom = formatter.format(from!);
                                     model.  formattedTo = formatter.format(to);
                                     Navigator.of(context).pop();
                                     setState((){});
                                     model.setIdle();

                                   }




                                   setState((){});
                                   model.setIdle();
                                 },
                               );


                                  },

                                  )
                                ),
                              );
                            });
                          },
                          child: Container(
                            width: 150,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text((model. formattedFrom??"")+" - "+ (model.formattedTo ??""),style: const TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.w600),),

                          ),
                        ),
                        const SizedBox(height: 16,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 6),

                              width: SizeConfig.width*.35,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                Border.all(color:AppColors.formFill2),
                                color: AppColors.formFill,
                              ),
                              child: DropdownButton<String>(
                                style: TextStyle(color: AppColors.primaryColor),

                                value: model.selectedTravels,
                                icon: const Icon(
                                  color: AppColors.primaryColor,
                                  Icons.arrow_downward,
                                  size: 0,
                                ),
                                elevation: 16,
                                underline: Container(),
                                onChanged: (String? value) {
                                  model.selectedTravels = value!;
                                  model.setState();
                                },
                                items: model.travels
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 6),
                              width: SizeConfig.width*.35,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                Border.all(color:AppColors.formFill2),
                                color: AppColors.formFill,
                              ),
                              child: DropdownButton<String>(
                                style: TextStyle(color: AppColors.primaryColor),

                                value: model.selectedClass,
                                icon: const Icon(
                                  color: AppColors.primaryColor,
                                  Icons.arrow_downward,
                                  size: 0,
                                ),
                                elevation: 16,
                                underline: Container(),
                                onChanged: (String? value) {
                                  model.selectedClass = value!;
                                  model.setState();
                                },
                                items: model.classes
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16,),

                        ElevatedButton(onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonColor
                          ), child: const Text("Search Flights",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),

                        ),

                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: SizeConfig.height*.2,left: 21),
                      child: const Text("Book Your\nFlight",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.1, // Adjust the line height as needed
                        ), )),
                  GestureDetector (
                    onTap: (){
                      String? temp =  model.selectedCountryFrom ;
                      model.selectedCountryFrom=model.selectedCountryTo;
                      model.selectedCountryTo=temp;
                      model.setIdle();



                    },
                    child: Container(
                      padding: EdgeInsets.only(top: SizeConfig.height*.44),
                      alignment: Alignment.topCenter,
                        child: SvgPicture.asset("images/svgs/Group 68.svg")
                    ),
                  ),
                  (model.selectedCountryFrom!=null || model.selectedCountryTo!=null)?
                  Container(
                    padding: EdgeInsets.only(left: 16+16+16+5,top: SizeConfig.height*.43),
                    alignment: Alignment.topLeft,
                    child:SvgPicture.asset("images/svgs/Vector 38.svg",height: 60,),
                  )
                      :Container(),
                ],
              )
            ),
              bottomNavigationBar: BottomAppBar(
                 padding: const EdgeInsets.all(0),
                    notchMargin: 10,
                  height: SizeConfig.height*.08,
                color: AppColors.primaryColor,
                shape: const CircularNotchedRectangle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset("images/svgs/menu - home.svg",height: 68,width:64,fit: BoxFit.fill,),
                    SvgPicture.asset("images/svgs/menu - home 2.svg",height: 68,width:64,fit: BoxFit.fill,)
                  ],
                )
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              backgroundColor:AppColors.primaryColor,
                shape: const CircleBorder(),
                onPressed: (){},
              child: SvgPicture.asset("images/svgs/planVector.svg")
            ),
          ),
        );

      },
    );
  }
}

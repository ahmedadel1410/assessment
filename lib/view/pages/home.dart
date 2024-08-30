// ignore_for_file: file_names
import 'package:assessment/model/services/core_helper/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import '../../model/services/base/base_widget.dart';
import '../../view_model/home_vm.dart';
import '../styles/app_colors.dart';
import '../styles/text_styles.dart';

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
              onRefresh: ()async{

              },
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
                         Expanded(child: SizedBox()),
                         TabBar(
                           indicatorSize: TabBarIndicatorSize.label,
                           unselectedLabelStyle: TextStyle(color: Colors.white.withOpacity(.5)),
                           labelStyle: TextStyle(color: Colors.white),
                           indicatorColor: Colors.white,
                           dividerColor: Colors.white.withOpacity(0),
                            indicatorPadding: EdgeInsets.only(right: 40),


                           tabs: [
                             Text("Round Trip"),
                             Text("One-Way"),
                             Text("Multi City"),
                           ],
                         ),

                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.height*.35,left: 22,right: 22),
                    alignment: Alignment.bottomCenter,
                    height: SizeConfig.height*.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: ListView(
                      padding: EdgeInsets.only(left: 16,top: 50),
                      children: [
                        Container(child: Text("dfgdf"),)
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: SizeConfig.height*.2,left: 21),
                      child: Text("Book Your\nFlight",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.1, // Adjust the line height as needed
                        ), ))

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

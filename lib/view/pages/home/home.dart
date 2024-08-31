// ignore_for_file: file_names
import 'package:assessment/model/services/core_helper/size_config.dart';
import 'package:assessment/view/pages/home/floating_button.dart';
import 'package:assessment/view/styles/main_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import '../../../model/services/base/base_widget.dart';
import '../../../view_model/home_vm.dart';
import '../../styles/app_colors.dart';
import 'bottom_bar.dart';
import 'cover_banner.dart';
import 'middle_form.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    return BaseWidget<HomeModel>(
      model: HomeModel(context: context),
      initState: (model) async {
      await model.getUsers();
      },
      builder: (_, model, child) {
        return  DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: AppColors.background,
            body:(model.busy)?const MainProgress():RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: ()async{},
              child: Stack(
                children: [
                  CoverBanner(),
                  MiddleForm(model:model),
                  //book your flight text
                  Container(
                    padding: EdgeInsets.only(top: SizeConfig.height*.2,left: 21),
                      child: const Text("Book Your\nFlight",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.1, // Adjust the line height as needed
                        ), )),
                  //sawpe button
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
                  //dotted widget
                  (model.selectedCountryFrom!=null || model.selectedCountryTo!=null)?
                  Container(
                    padding: EdgeInsets.only(left: 16+16+16+5,top: SizeConfig.height*.43),
                    alignment: Alignment.topLeft,
                    child:SvgPicture.asset("images/svgs/Vector 38.svg",height: 60,),
                  ) :Container(),
                ],
              )
            ),
              bottomNavigationBar:BottomBar() ,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingButton()
          ),
        );

      },
    );
  }
}

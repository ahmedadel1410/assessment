import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/services/core_helper/size_config.dart';
import '../../styles/app_colors.dart';

class CoverBanner extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return                   Container(
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
    );

  }

}
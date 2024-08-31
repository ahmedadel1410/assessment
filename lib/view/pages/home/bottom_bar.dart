import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../model/services/core_helper/size_config.dart';
import '../../styles/app_colors.dart';

class BottomBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return   BottomAppBar(
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
    );
  }

}
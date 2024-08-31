import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../styles/app_colors.dart';

class FloatingButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return FloatingActionButton(
       backgroundColor:AppColors.primaryColor,
       shape: const CircleBorder(),
       onPressed: (){},
       child: SvgPicture.asset("images/svgs/planVector.svg")
   );
  }

}


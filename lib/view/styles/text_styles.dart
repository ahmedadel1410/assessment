import 'package:flutter/material.dart';


class TextStyles {

     static  TextStyle fontStyle({required double size , required FontWeight fontWeight, required Color color,Color? background}){
        return  TextStyle(
            backgroundColor: background,
             height: 1.5,
          color: color,
          fontWeight: fontWeight,
          fontSize: size,
        );
       }
  static const maintitle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

}

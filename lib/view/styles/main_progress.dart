import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/services/core_helper/size_config.dart';
import 'app_colors.dart';

enum ProgressType { circular, linear }

class MainProgress extends StatelessWidget {
  final Color color;
  final double diameter;
  final double stroke;
  final ProgressType type;
  final double height;
  final double? linearWidth;

  const MainProgress({
    Key? key,
    this.color = AppColors.primaryColor,
    this.stroke = 4,
    this.diameter = 30,
    this.height = 4,
    this.linearWidth,
    this.type = ProgressType.circular,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget progress;
    switch (type) {
      case ProgressType.circular:
        progress = Platform.isAndroid
            ? Center(
                child: SizedBox(
                  height: diameter,
                  width: diameter,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    strokeWidth: stroke,
                  ),
                ),
              )
            : Center(
                child: SizedBox(
                  height: diameter,
                  width: diameter,
                  // height: diameter * 0.5,
                  // width: diameter * 0.5,
                  child: CupertinoActivityIndicator(
                    radius: diameter * 0.8,
                  ),
                ),
              );
        break;
      case ProgressType.linear:
        progress = SizedBox(
          width: SizeConfig.width,
          child: LinearProgressIndicator(
            minHeight: height,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        );
        break;
    }
    return progress;
  }
}

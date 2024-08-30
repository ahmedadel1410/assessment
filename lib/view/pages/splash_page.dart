// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../../../model/services/base/base_widget.dart';
import '../../../model/services/core_helper/size_config.dart';
import '../../view_model/splasg_vm.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SplashPageModel>(
      model: SplashPageModel(context: context),
      builder: (_, model, child) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              width: SizeConfig.width*.15,
              height: SizeConfig.height*.15,
              padding: const EdgeInsets.all(10),
              child:Image.asset("images/splash.png")
            ),
          ),
        );
      },
    );
  }
}

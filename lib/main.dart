import 'package:assessment/view/pages/home.dart';
import 'package:assessment/view_model/filter_cubit.dart';
import 'package:assessment/view_model/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider<HomeCubit>(create: (context) => HomeCubit(context: context)),
            BlocProvider<FilterCubit>(create: (context) => FilterCubit(context: context)),
          ],
          child: const MyApp()

      )

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'waffrha',
      home: HomePage(),
    );
  }
}

import 'package:assessment/view/pages/home.dart';
import 'package:assessment/view_model/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart'; // Import MultiProvider

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MVVM with BLoC',
      home: MultiProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit(context: context)),
          // BlocProvider(create: (context) => AnotherCubit()), // Add more providers here
        ],
        child: HomePage(),
      ),
    );
  }
}

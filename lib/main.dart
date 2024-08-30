import 'dart:io';
import 'package:assessment/view/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'model/services/core_helper/preference.dart';
import 'model/services/core_helper/size_config.dart';
import 'model/services/localization/app_localization.dart';
import 'model/services/provider/provider_setup.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Preference.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().initialize(constraints, orientation);
        return MultiProvider(
          providers: providers,
          child: Consumer<AppLanguage>(
            builder: (context, language, _) => MaterialApp(
              title: 'assessment',
              debugShowCheckedModeBanner: true,
              home: const SplashPage(),
              locale: language.appLocale,
              supportedLocales: const [
                Locale("en"),
                Locale("ar"),
              ],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            ),
          ),
        );
      });
    });
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

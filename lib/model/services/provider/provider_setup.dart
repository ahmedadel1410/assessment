import 'package:assessment/model/services/localization/app_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../http/http_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => HttpService());
  locator.registerFactory(() => AppLanguageBloc());

}
HttpService api = HttpService();


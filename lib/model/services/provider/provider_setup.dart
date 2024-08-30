import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../http/http_service.dart';
import '../localization/app_localization.dart';


final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => HttpService());
}

List<SingleChildWidget> providers = [
  ...servicesProviders,
];
HttpService api = HttpService();
List<SingleChildWidget> servicesProviders = [
  ChangeNotifierProvider(create: (_) => AppLanguage()),
];

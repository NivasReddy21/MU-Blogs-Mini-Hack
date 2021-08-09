import 'package:get_it/get_it.dart';
import 'package:mu_blogs/Services/NavigationService.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}

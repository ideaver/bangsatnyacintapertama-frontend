import 'package:alvamind_library_two/app/service/network_checker/network_checker_service.dart';
import 'package:get_it/get_it.dart';

import '../../../view_model/main_view_model.dart';

final GetIt locator = GetIt.instance;

// Service Locator
void setupServiceLocator() {
  locator.registerLazySingleton(() => NetworkCheckerService());
  locator.registerLazySingleton(() => MainViewModel());
}

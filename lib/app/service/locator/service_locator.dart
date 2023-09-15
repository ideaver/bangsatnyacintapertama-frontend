import 'package:alvamind_library_two/app/service/network_checker/network_checker_service.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

// Service Locator
void setupServiceLocator() {
  locator.registerLazySingleton(() => NetworkCheckerService());
}

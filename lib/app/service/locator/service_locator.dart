import 'package:get_it/get_it.dart';

import '../../../view_model/check_in_view_model.dart';
import '../../../view_model/dashboard_view_model.dart';
import '../../../view_model/guest_add_edit_view.dart';
import '../../../view_model/guest_invitation_view_model.dart';
import '../../../view_model/login_view_model.dart';
import '../../../view_model/main_view_model.dart';
import '../network_checker/network_checker_service.dart';

final GetIt locator = GetIt.instance;

// Service Locator
void setupServiceLocator() {
  locator.registerLazySingleton(() => NetworkCheckerService());
  locator.registerLazySingleton(() => MainViewModel());
  locator.registerLazySingleton(() => DashboardViewModel());
  locator.registerLazySingleton(() => GuestInvitationViewModel());
  locator.registerLazySingleton(() => CheckInViewModel());
  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => GuestAddEditViewModel());
}

import 'package:alvamind_library_two/app/service/network_checker/network_checker_service.dart';
import 'package:alvamind_library_two/app/utility/console_log.dart';
import 'package:alvamind_library_two/widget/atom/app_dialog.dart';
import 'package:flutter/material.dart';

import '../app/service/auth/auth_service.dart';
import '../app/service/locator/service_locator.dart';

class MainViewModel extends ChangeNotifier {
  // Singleton services
  final networkService = locator<NetworkCheckerService>();
  // final userViewModel = locator<UserViewModel>();

  // Factory services
  // final loginViewModel = locator<LoginViewModel>();

  bool isChecking = true;
  bool isLoggedIn = true;

  int selectedPageIndex = 0;

  // For log out purpose
  void resetState() {
    isChecking = true;
    isLoggedIn = false;
    selectedPageIndex = 0;

    // Reset singleton services
    // dashboardViewModel.resetState();
  }

  Future<void> checkIsLoggedIn() async {
    isChecking = true;
    notifyListeners();

    await AuthService.initAuth();

    // login user
    if (AuthService.auth != null) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }

    cl('[checkIsLoggedIn].isLoggedIn = $isLoggedIn');

    isChecking = false;
    notifyListeners();
  }

  void initMainView(NavigatorState navigator) async {
    // Check login status
    await checkIsLoggedIn();

    // Init network checker service
    await networkService.initNetworkChecker(
      navigator: navigator,
      onHasInternet: (status) {
        // if (status) {
        //   refreshMainView(navigator);
        // }
      },
    );

    // Init main view
    await refreshMainView(navigator);
  }

  Future<void> refreshMainView(NavigatorState navigator) async {
    try {
      if (isLoggedIn) {
        // await userViewModel.getUser();

        // check is user exist
        // if (userViewModel.user == null) {
        //   showLoginErrorDialog(
        //     navigator,
        //     error: 'User Null',
        //   );
        //   return;
        // }

        // await programListViewModel.getAllPrograms();
        // await memberListViewModel.getAllUserMembers();
      }
    } catch (e) {
      cl(e);
      showLoginErrorDialog(navigator, error: e.toString());
    }
  }

  void onChangedPage(int i) {
    selectedPageIndex = i;
    notifyListeners();
  }

  void showLoginErrorDialog(NavigatorState navigator, {String? error, String? customMessage}) {
    var errorMessage = error.toString().length > 50 ? error.toString().substring(0, 50) : error.toString();

    var defaultMessage = "Something went wrong, please contact your system administrator or try restart the app";

    var message = customMessage ?? defaultMessage;

    AuthService.logOut(navigator);

    AppDialog.showErrorDialog(
      navigator,
      error: '$message\n\n$errorMessage',
    );
  }
}

import 'package:alvamind_library_two/app/service/network_checker/network_checker_service.dart';
import 'package:alvamind_library_two/app/service/storage/local_storage_service.dart';
import 'package:alvamind_library_two/app/utility/console_log.dart';
import 'package:alvamind_library_two/widget/atom/app_dialog.dart';
import 'package:flutter/material.dart';

import '../app/service/locator/service_locator.dart';

class MainViewModel extends ChangeNotifier {
  // Singleton services
  final networkService = locator<NetworkCheckerService>();

  // Factory services
  // final loginViewModel = locator<LoginViewModel>();

  String? userId;
  bool isChecking = true;

  int selectedPageIndex = 0;

  // For log out purpose
  void resetState() {
    userId = null;
    isChecking = false;
    selectedPageIndex = 0;

    // Reset singleton services
    // dashboardViewModel.resetState();
  }

  Future<void> checkIsLoggedIn() async {
    final savedUserId = await LocalStorageService.readData(
      LocalStorageKey.userId,
    );

    if (savedUserId != null) {
      userId = savedUserId;
      isChecking = false;

      notifyListeners();
      return;
    } else {
      userId = null;
      isChecking = false;

      notifyListeners();
      return;
    }
  }

  void initMainView(NavigatorState navigator) async {
    // Check login status
    await checkIsLoggedIn();

    // Init network checker service
    await networkService.initNetworkChecker(
      navigator: navigator,
      onHasInternet: (status) {
        if (status) {
          refreshMainView(navigator);
        }
      },
    );

    // Init main view
    await refreshMainView(navigator);
  }

  Future<void> refreshMainView(NavigatorState navigator) async {
    try {
      if (userId != null) {
        // Get user data
        // await userViewModel.getUser(userId!);
      }
    } catch (e) {
      cl(e);

      // Force logout user
      // loginViewModel.logOut(navigator);

      AppDialog.showErrorDialog(navigator);
    }
  }

  void onChangedPage(int i) {
    selectedPageIndex = i;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

import '../app/service/auth/auth_service.dart';
import '../app/utility/console_log.dart';
import '../view/main/main_view.dart';
import '../widget/atom/app_dialog.dart';
import '../widget/atom/app_snackbar.dart';

class LoginViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> onLogin(NavigatorState navigator) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      AppSnackbar.show(navigator, title: "Email dan password tidak boleh kosong");
      return;
    }

    AppDialog.showDialogProgress(navigator);

    var res = await AuthService.login(
      email: emailController.text,
      password: passwordController.text,
    );

    if (res == null) {
      navigator.pop();
      navigator.pushNamedAndRemoveUntil(
        MainView.routeName,
        (route) => false,
      );
    } else {
      cl('[onLogin].error $res');
      navigator.pop();
      AppDialog.showErrorDialog(navigator, message: res);
    }
  }
}

import 'package:bangsatnyacintapertama/view/dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';

import '../../../../view/main/main_view.dart';
import '../../view/auth/login_view.dart';
import '../../view/auth/reset_pass_view.dart';
import '../../view/check_in/check_in_view.dart';
import '../../view/check_in/qr_code_scanner_view.dart';
import '../../view/invited_guest/invited_guest_view.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    MainView.routeName: (context) => const MainView(),
    LoginView.routeName: (context) => const LoginView(),
    ResetPasswordView.routeName: (context) => const ResetPasswordView(),
    DashboardView.routeName: (context) => const DashboardView(),
    InvitedGuestView.routeName: (context) => const InvitedGuestView(),
    CheckInView.routeName: (context) => const CheckInView(),
    QRCodeScannerView.routeName: (context) => const QRCodeScannerView(),
  };
}

import 'package:bangsatnyacintapertama/view/dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';

import '../../../../view/main/main_view.dart';
import '../../view/invited_guest/invited_guest_view.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    MainView.routeName: (context) => const MainView(),
    DashboardView.routeName: (context) => const DashboardView(),
    InvitedGuestView.routeName: (context) => const InvitedGuestView(),
  };
}

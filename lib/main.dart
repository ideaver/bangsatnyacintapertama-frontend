import 'package:alvamind_library_two/app/locale/app_locale.dart';
import 'package:alvamind_library_two/app/service/network_checker/network_checker_service.dart';
import 'package:alvamind_library_two/app/theme/app_theme.dart';
import 'package:bangsatnyacintapertama/view_model/check_in_view_model.dart';
import 'package:bangsatnyacintapertama/view_model/dashboard_view_model.dart';
import 'package:bangsatnyacintapertama/view_model/guest_invitation_view_model.dart';
import 'package:bangsatnyacintapertama/view_model/main_view_model.dart';
import 'package:bangsatnyacintapertama_graphql_client/graphql_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'app/routes/app_routes.dart';
import 'app/service/auth/auth_service.dart';
import 'app/service/locator/service_locator.dart';
import 'view/main/main_view.dart';

void main() {
  // Initialize binding
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize date formatting
  initializeDateFormatting();

  // Setup service locator
  setupServiceLocator();

  // Initialize Firebase (google-service.json required)
  // await Firebase.initializeApp();

  // Initialize FCM service (google-service.json required)
  // await FcmService.initNotification(
  //   onMessageHandler: (message) {},
  //   onBackgroundHandler: (message) {},
  // );

  // Initialize local notification service
  // await LocalNotifService.initLocalNotifService(
  //   packageName: "com.satujuta.web",
  //   channelName: "satujuta web notification",
  // );

  // Initialize GraphQLService
  GraphQLService.init(getToken: AuthService.getToken);

  // Set/lock orientationgvhvgj
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Set overlay style
  SystemChrome.setSystemUIOverlayStyle(AppTheme.lightOverlayStyle);

  runApp(const MyApp());
}

// Root widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Providers
        ChangeNotifierProvider(create: (_) => locator<NetworkCheckerService>()),
        ChangeNotifierProvider(create: (_) => locator<MainViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<DashboardViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<GuestInvitationViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<CheckInViewModel>()),
      ],
      child: MaterialApp(
        title: 'Bangsatnya Cinta Pertama',
        theme: AppTheme.getTheme(),
        debugShowCheckedModeBanner: true,
        initialRoute: MainView.routeName,
        routes: AppRoutes.routes,
        home: const MainView(),
        locale: AppLocale.defaultLocale,
        supportedLocales: AppLocale.supportedLocales,
        localizationsDelegates: AppLocale.localizationsDelegates,
      ),
    );
  }
}

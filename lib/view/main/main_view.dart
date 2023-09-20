import 'package:alvamind_library_two/app/asset/app_icons.dart';
import 'package:alvamind_library_two/app/theme/app_colors.dart';
import 'package:alvamind_library_two/app/theme/app_sizes.dart';
import 'package:alvamind_library_two/app/theme/app_text_style.dart';
import 'package:alvamind_library_two/model/sidebar_menu_model.dart';
import 'package:alvamind_library_two/widget/atom/app_button.dart';
import 'package:alvamind_library_two/widget/atom/app_icon_button.dart';
import 'package:alvamind_library_two/widget/atom/app_progress_indicator.dart';
import 'package:alvamind_library_two/widget/organism/sidebar/sidebar.dart';
import 'package:bangsatnyacintapertama/view/invitation_guest/invitation_guest_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/service/locator/service_locator.dart';
import '../../view_model/main_view_model.dart';
import '../auth/login_view.dart';
import '../check_in/check_in_view.dart';
import '../check_in/qr_code_scanner_view.dart';
import '../dashboard/dashboard_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  static const String routeName = '/main';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final mainViewModel = locator<MainViewModel>();

  List<SideBarMenuModel> menuItems = [
    SideBarMenuModel(
      icon: CustomIcon.document_icon,
      title: "Dashboard",
      showDivider: true,
    ),
    SideBarMenuModel(
      icon: Icons.person_outline,
      title: "Tamu Undangan",
    ),
    SideBarMenuModel(
      icon: CustomIcon.receipt_icon,
      title: "Check-In Tamu",
    ),
    // SideBarMenuModel(
    //   icon: CustomIcon.program_icon,
    //   title: "Upload Data Tamu",
    // ),
    // SideBarMenuModel(
    //   icon: CustomIcon.settings_icon,
    //   title: "Pengaturan",
    // ),
  ];

  List<Widget> pages = [
    const DashboardView(),
    const InvitationGuestView(),
    const CheckInView(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final navigator = Navigator.of(context);
      final mainViewModel = locator<MainViewModel>();

      mainViewModel.initMainView(navigator);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, model, _) {
        if (!mainViewModel.isChecking) {
          if (!mainViewModel.isLoggedIn) {
            return const LoginView();
          }
        } else {
          return const Center(child: AppProgressIndicator());
        }

        return SideBar(
          selectedIndex: model.selectedPageIndex,
          pages: pages,
          menuItems: menuItems,
          onTapBar: model.onChangedPage,
          footerExpandedWidget: footerExpandedWidget(),
          footerShrinkedWidget: footerShrinkedWidget(),
        );
      },
    );
  }

  Widget footerExpandedWidget() {
    return Column(
      children: [
        // const AppImage(
        //   image: AppAssets.longLogoPath,
        //   imgProvider: ImgProvider.assetImage,
        // ),
        Text(
          'Bangsatnya Cinta Pertama',
          style: AppTextStyle.bold(context, fontSize: 16),
        ),
        const SizedBox(height: AppSizes.padding * 1.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'v2 1.0 (12345)',
              style: AppTextStyle.regular(context, fontSize: 12),
            ),
            const SizedBox(width: AppSizes.padding / 2),
            AppButton(
              text: 'Tentang',
              fontSize: 10,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.padding / 2,
                vertical: AppSizes.padding / 4,
              ),
              onTap: () {
                // TODO
              },
            ),
          ],
        ),
        const SizedBox(height: AppSizes.padding * 1.5),
        AppButton(
          leftIcon: CustomIcon.copy_document,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.padding,
            vertical: AppSizes.padding / 1.5,
          ),
          text: 'SCAN QRCode',
          onTap: () async {
            mainViewModel.onChangedPage(2);
            Navigator.pushNamed(context, QRCodeScannerView.routeName);
          },
        ),
      ],
    );
  }

  Widget footerShrinkedWidget() {
    return AppIconButton(
      icon: CustomIcon.logout_icon,
      iconColor: Colors.white,
      iconSize: 14,
      padding: const EdgeInsets.all(AppSizes.padding / 2),
      backgroundColor: AppColors.primary,
      onPressed: () {
        // TODO
      },
    );
  }
}

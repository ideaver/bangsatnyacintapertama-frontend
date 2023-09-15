import 'package:alvamind_library_two/app/asset/app_icons.dart';
import 'package:alvamind_library_two/app/theme/app_colors.dart';
import 'package:alvamind_library_two/app/theme/app_sizes.dart';
import 'package:alvamind_library_two/app/theme/app_text_style.dart';
import 'package:alvamind_library_two/model/sidebar_menu_model.dart';
import 'package:alvamind_library_two/widget/atom/app_button.dart';
import 'package:alvamind_library_two/widget/atom/app_image.dart';
import 'package:alvamind_library_two/widget/atom/my_icon_button.dart';
import 'package:alvamind_library_two/widget/organism/sidebar/sidebar.dart';
import 'package:flutter/material.dart';

import '../../app/asset/app_assets.dart';
import '../dashboard/dashboard_view.dart';
import '../invited_guest/invited_guest_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  static const String routeName = '/main';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int index = 0;

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
    SideBarMenuModel(
      icon: CustomIcon.program_icon,
      title: "Upload Data Tamu",
    ),
    SideBarMenuModel(
      icon: CustomIcon.settings_icon,
      title: "Pengaturan",
    ),
  ];

  List<Widget> pages = [
    const DashboardView(),
    const InvitedGuestView(),
  ];

  @override
  Widget build(BuildContext context) {
    return SideBar(
      selectedIndex: index,
      pages: pages,
      menuItems: menuItems,
      onTapBar: (value) {
        index = value;
        setState(() {});
      },
      footerExpandedWidget: footerExpandedWidget(),
      footerShrinkedWidget: footerShrinkedWidget(),
    );
  }

  Widget footerExpandedWidget() {
    return Column(
      children: [
        const AppImage(
          image: AppAssets.longLogoPath,
          imgProvider: ImgProvider.assetImage,
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
          onTap: () {
            // TODO
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

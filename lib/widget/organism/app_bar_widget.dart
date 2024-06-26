import 'package:flutter/material.dart';
import 'package:responsive_toolkit/responsive_toolkit.dart';

import '../../app/asset/app_icons.dart';
import '../../app/service/auth/auth_service.dart';
import '../../model/menu_item_model.dart';
import '../atom/app_dialog.dart';
import '../molecule/custom_app_bar.dart';

List<MenuItemModel> _accountDropdownItems(NavigatorState navigator) {
  return [
    // MenuItemModel(
    //   text: 'Akun',
    //   icon: const Icon(Icons.person_outline),
    //   onTap: () {},
    // ),
    // MenuItemModel(
    //   text: 'Pengaturan',
    //   icon: const Icon(CustomIcon.settings_icon),
    //   onTap: () {},
    // ),
    MenuItemModel(
      text: 'Log Out',
      icon: const Icon(CustomIcon.logout_icon),
      onTap: () {
        AppDialog.show(
          navigator,
          title: "Log Out",
          text: "Apakah Anda yakin ingin keluar akun?",
          rightButtonText: "Keluar",
          leftButtonText: "Batal",
          onTapRightButton: () async {
            navigator.pop();
            AuthService.logOut(navigator);
          },
        );
      },
    ),
  ];
}

PreferredSizeWidget appBarWidget({
  required NavigatorState navigator,
  required String title,
}) {
  return CustomAppBar(
    title: title,
    userName: AuthService.user?.fullName ?? '',
    userRole: AuthService.user?.role.name ?? '',
    // userImage: randomImage,
    accountDropdownItems: _accountDropdownItems(navigator),
    height: ResponsiveLayout.value(navigator.context, Breakpoints(xs: 94, md: 94)),
    // height: ResponsiveLayout.value(navigator.context, Breakpoints(xs: 94 * 1.8, md: 94)),
  );
}

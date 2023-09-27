import 'package:flutter/material.dart';
import 'package:responsive_toolkit/breakpoints.dart';
import 'package:responsive_toolkit/responsive_layout.dart';

import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_style.dart';
import '../../model/menu_item_model.dart';
import 'user_dropdown.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Widget? subtitleWidget;
  final List<MenuItemModel> accountDropdownItems;
  final List<Widget> additionalWidgets;
  final String userName;
  final String? userRole;
  final String? userImage;
  final String searchHintText;
  final double height;
  final Function()? onTapSearch;
  final Function(String)? onChangedSearch;
  final Function()? onEditingComplete;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitleWidget,
    this.accountDropdownItems = const [],
    this.additionalWidgets = const [],
    required this.userName,
    this.userRole,
    this.userImage,
    this.height = 94,
    this.onTapSearch,
    this.onChangedSearch,
    this.onEditingComplete,
    this.searchHintText = 'Cari Nama/ID Number',
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      Breakpoints(
        xs: compactAppBar(),
        md: widget.additionalWidgets.isEmpty ? wideAppBar() : null,
        lg: wideAppBar(),
      ),
    );
  }

  Widget title() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.extraBold(
            context,
            fontSize: ResponsiveLayout.value(
              context,
              Breakpoints(
                xs: 26,
                md: 32,
              ),
            ),
          ),
        ),
        widget.subtitleWidget ?? const SizedBox.shrink(),
      ],
    );
  }

  Widget compactAppBar() {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.padding),
      child: Column(
        children: [
          // child: Expanded(
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: title()),
                userDropDownButton(),
              ],
            ),
          ),
          // ),
          // const SizedBox(height: AppSizes.padding),
          // searchField(),
        ],
      ),
    );
  }

  // Widget menu() {
  //   return Align(
  //     alignment: Alignment.centerRight,
  //     child: AppTooltip(
  //       arrowLength: 0,
  //       content: AppCardContainer(
  //         margin: EdgeInsets.zero,
  //         boxShadow: [AppShadows.cardShadow3],
  //         child: SizedBox(
  //           width: 200,
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               AppTextField(
  //                 type: AppTextFieldType.search,
  //                 showSuffixButton: false,
  //                 prefixIcon: const Icon(
  //                   Icons.search,
  //                   size: 14,
  //                 ),
  //                 fillColor: AppColors.baseLv7,
  //                 padding: EdgeInsets.zero,
  //                 hintText: 'Cari Nama/ID Number',
  //                 onChanged: (value) {
  //                   // TODO
  //                 },
  //               ),
  //               const SizedBox(height: AppSizes.padding),
  //               AppTextButton(
  //                 icon: Icons.person_outline,
  //                 text: 'Akun',
  //                 onTap: () {},
  //               ),
  //               const SizedBox(height: AppSizes.padding),
  //               AppTextButton(
  //                 icon: CustomIcon.settings_icon,
  //                 text: 'Pengaturan',
  //                 onTap: () {},
  //               ),
  //               const SizedBox(height: AppSizes.padding),
  //               AppTextButton(
  //                 icon: CustomIcon.logout_icon,
  //                 text: 'Logout',
  //                 onTap: () {},
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       child: const CircleAvatar(
  //         backgroundColor: AppColors.baseLv7,
  //         child: Icon(
  //           Icons.menu,
  //           color: AppColors.base,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget wideAppBar() {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: title(),
          ),
          userDropDownButton(),
          // Expanded(
          //   child: Row(
          //     children: [
          //       ...widget.additionalWidgets,
          //       // const SizedBox(width: AppSizes.padding / 2),
          //       // searchField(),
          //       const SizedBox(width: AppSizes.padding / 2),
          //       userDropDownButton(),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  Widget userDropDownButton() {
    return UserDropdown(
      userName: widget.userName,
      userRole: widget.userRole,
      userImage: widget.userImage,
      accountDropdownItems: widget.accountDropdownItems,
    );
  }

  // Widget searchField() {
  //   return Expanded(
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: AppColors.white,
  //         borderRadius: BorderRadius.circular(100),
  //       ),
  //       child: AppTextField(
  //         type: AppTextFieldType.search,
  //         padding: const EdgeInsets.symmetric(
  //           vertical: AppSizes.padding / 4,
  //           horizontal: AppSizes.padding / 2,
  //         ),
  //         showSuffixButton: false,
  //         prefixIcon: const Icon(Icons.search),
  //         fillColor: AppColors.white,
  //         hintText: widget.searchHintText,
  //         onTap: widget.onTapSearch,
  //         onChanged: widget.onChangedSearch,
  //         onEditingComplete: widget.onEditingComplete,
  //       ),
  //     ),
  //   );
  // }
}




import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_shadows.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_style.dart';
import '../../model/menu_item_model.dart';
import '../atom/app_dropdown.dart';
import 'profile_user.dart';

class UserDropdown extends StatefulWidget {
  final String userName;
  final String? userRole;
  final String? userImage;
  final List<MenuItemModel> accountDropdownItems;

  const UserDropdown({
    super.key,
    required this.userName,
    required this.userRole,
    this.userImage,
    required this.accountDropdownItems,
  });

  @override
  State<UserDropdown> createState() => _UserDropdownState();
}

class _UserDropdownState extends State<UserDropdown> {
  @override
  Widget build(BuildContext context) {
    return AppDropDown(
      customButton: SizedBox(
        child: ProfileUser(
          title: widget.userName,
          subtitle: widget.userRole ?? '',
          image: widget.userImage,
          titleTextStyle: AppTextStyle.bold(context, fontSize: 14),
          subtitleTextStyle: AppTextStyle.regular(context, fontSize: 12),
          backgroundColor: AppColors.white,
          padding: const EdgeInsets.all(AppSizes.padding / 2),
          onTap: (value) {},
        ),
      ),
      items: [
        ...widget.accountDropdownItems.map(
          (item) => DropdownMenuItem<MenuItemModel>(
            value: item,
            child: buildItem(item),
          ),
        ),
      ],
      dropdownStyleData: DropdownStyleData(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radius * 2),
          color: Colors.white,
          boxShadow: [AppShadows.cardShadow3],
        ),
        offset: const Offset(0, -10),
      ),
    );
  }

  Widget buildItem(MenuItemModel item) {
    if (item.child != null) {
      return item.child!;
    }

    return GestureDetector(
      onTap: item.onTap ?? () {},
      child: Row(
        children: [
          item.icon == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(right: AppSizes.padding / 2),
                  child: item.icon,
                ),
          Expanded(
            child: Text(
              item.text ?? '',
              style: const TextStyle(
                color: AppColors.base,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

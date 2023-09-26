import 'package:flutter/material.dart';
import 'package:responsive_toolkit/responsive_toolkit.dart';

import '../../../model/sidebar_menu_model.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_style.dart';
import '../atom/app_icon_button.dart';
import '../atom/app_image.dart';

class SideBar extends StatefulWidget {
  final PageController? pageController;
  final List<SideBarMenuModel> menuItems;
  final List<Widget> pages;
  final int selectedIndex;
  final void Function(int) onTapBar;
  final Widget footerExpandedWidget;
  final Widget footerShrinkedWidget;

  const SideBar({
    super.key,
    required this.pages,
    required this.menuItems,
    this.pageController,
    required this.selectedIndex,
    required this.onTapBar,
    this.footerExpandedWidget = const SizedBox.shrink(),
    this.footerShrinkedWidget = const SizedBox.shrink(),
  });

  @override
  SideBarState createState() => SideBarState();
}

class SideBarState extends State<SideBar> {
  // List<String> titleList = [
  //   'Dashboard',
  //   'Laporan',
  //   'Member',
  //   'Transaksi',
  //   'Program',
  //   'Hotel',
  //   'Project',
  //   'Marketing Kit',
  //   'Pengaturan',
  //   'Tentang Aplikasi',
  // ];

  // List<IconData> iconList = [
  //   CustomIcon.layer_icon,
  //   CustomIcon.document_icon,
  //   Icons.person_outline,
  //   CustomIcon.receipt_icon,
  //   CustomIcon.program_icon,
  //   CustomIcon.buliding_icon,
  //   Icons.feed_outlined,
  //   CustomIcon.note2_icon,
  //   CustomIcon.settings_icon,
  //   Icons.info_outline,
  // ];

  bool isExpand = true;

  @override
  void initState() {
    if (AppSizes.screenSize.width > 768) {
      isExpand = true;
    } else {
      isExpand = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      Breakpoints(
        xs: drawer(),
        lg: sidebar(),
      ),
    );
  }

  Widget drawer() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 54),
          child: pagesBody(),
        ),
        AnimatedSize(
          curve: Curves.decelerate,
          alignment: Alignment.centerLeft,
          duration: const Duration(milliseconds: 200),
          child: Drawer(
            width: !isExpand ? 54 : 254,
            backgroundColor: Colors.white,
            elevation: !isExpand ? 0 : 54,
            shadowColor: AppColors.baseLv4,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.padding,
                horizontal: isExpand ? AppSizes.padding : 0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  header(),
                  menus(),
                  footer(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget sidebar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AnimatedSize(
          curve: Curves.decelerate,
          alignment: Alignment.centerLeft,
          duration: const Duration(milliseconds: 200),
          child: Drawer(
            width: !isExpand ? 54 : 254,
            backgroundColor: Colors.white,
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.padding,
                horizontal: isExpand ? AppSizes.padding : 0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  header(),
                  menus(),
                  footer(),
                ],
              ),
            ),
          ),
        ),
        Expanded(child: pagesBody()),
      ],
    );
  }

  Widget pagesBody() {
    return widget.pages[widget.selectedIndex];
  }

  Widget header() {
    return Column(
      children: [
        Align(
          alignment: isExpand ? Alignment.centerRight : Alignment.center,
          child: AppIconButton(
            icon: !isExpand ? Icons.chevron_right : Icons.chevron_left,
            iconSize: 20,
            iconColor: AppColors.white,
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.all(2),
            onPressed: () {
              isExpand = !isExpand;
              setState(() {});
            },
          ),
        ),
        const SizedBox(height: AppSizes.padding),
        Align(
          alignment: isExpand ? Alignment.centerLeft : Alignment.center,
          child: SizedBox(
            width: !isExpand ? 25 : 40,
            height: !isExpand ? 25 : 40,
            child: const AppImage(
              image: randomImage,
              borderRadius: 100,
            ),
          ),
        ),
        const SizedBox(height: AppSizes.padding),
      ],
    );
  }

  Widget menus() {
    return Expanded(
      child: Column(
        children: [
          ...List.generate(widget.menuItems.length, (index) {
            return SideItem(
              expand: isExpand,
              item: widget.menuItems[index],
              isSelected: widget.selectedIndex == index,
              onTap: () {
                widget.onTapBar(index);
                if (AppSizes.screenSize.width < 768) {
                  isExpand = false;
                }
                setState(() {});
              },
            );
          }),
        ],
      ),
    );
  }

  Widget footer() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: isExpand ? widget.footerExpandedWidget : widget.footerShrinkedWidget,
    );
  }
}

class SideItem extends StatefulWidget {
  final SideBarMenuModel item;

  final Color iconColor;
  final Color selectedIconColor;
  final double iconSize;
  final bool expand;
  final bool isSelected;
  final void Function() onTap;

  const SideItem({
    super.key,
    required this.item,
    required this.onTap,
    this.iconColor = AppColors.baseLv4,
    this.selectedIconColor = AppColors.primary,
    this.iconSize = 20,
    this.expand = true,
    this.isSelected = true,
  });

  @override
  State<SideItem> createState() => _SideItemState();
}

class _SideItemState extends State<SideItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            widget.onTap();
          },
          onHover: (value) {
            isHover = value;
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.padding / 1.5),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: !widget.expand
                  ? Icon(
                      widget.item.icon,
                      size: 20,
                      color: widget.isSelected || isHover ? widget.selectedIconColor : widget.iconColor,
                    )
                  : Row(
                      children: [
                        Icon(
                          widget.item.icon,
                          size: widget.iconSize,
                          color: widget.isSelected || isHover ? widget.selectedIconColor : widget.iconColor,
                        ),
                        const SizedBox(width: AppSizes.padding),
                        Text(
                          widget.item.title,
                          style: widget.isSelected || isHover
                              ? AppTextStyle.bold(
                                  context,
                                  fontSize: 14,
                                  color: AppColors.primary,
                                )
                              : AppTextStyle.medium(
                                  context,
                                  fontSize: 14,
                                  color: AppColors.baseLv4,
                                ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        widget.item.showDivider
            ? const Divider(
                thickness: 1,
                color: AppColors.baseLv6,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

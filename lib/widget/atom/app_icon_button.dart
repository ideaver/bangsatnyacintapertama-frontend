import 'package:flutter/material.dart';

import '../../app/theme/app_sizes.dart';
import 'app_image.dart';

class AppIconButton extends StatelessWidget {
  final Function()? onPressed;
  final IconData? icon;
  final String? imgIcon;
  final double? imgIconSize;
  final double? iconSize;
  final double borderRadius;
  final Color? iconColor;
  final Color? backgroundColor;
  final EdgeInsets padding;

  const AppIconButton({
    super.key,
    this.onPressed,
    this.icon,
    this.imgIcon,
    this.imgIconSize,
    this.iconSize,
    this.borderRadius = 100,
    this.iconColor,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(AppSizes.padding / 1.5),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: icon != null
            ? Icon(
                icon,
                size: iconSize ?? AppSizes.icon,
                color: iconColor,
              )
            : AppImage(
                image: imgIcon ?? '',
                width: imgIconSize ?? AppSizes.icon,
                imgProvider: ImgProvider.assetImage,
              ),
      ),
    );
  }
}

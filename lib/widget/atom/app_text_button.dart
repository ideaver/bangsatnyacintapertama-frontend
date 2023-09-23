import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_style.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final IconData? icon;
  final Color? iconColor;
  final Color? textColor;
  final double? iconSize;
  final double? textFontSize;
  final void Function() onTap;

  const AppTextButton({
    super.key,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.textStyle,
    required this.text,
    required this.onTap,
    this.textColor,
    this.textFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                        right: AppSizes.padding / 3,
                      ),
                      child: Icon(
                        icon,
                        size: iconSize ?? 16,
                        color: iconColor ?? AppColors.base,
                      ),
                    )
                  : const SizedBox.shrink(),
              Text(
                text,
                style: textStyle ??
                    AppTextStyle.bold(
                      context,
                      fontSize: textFontSize ?? 14,
                      color: textColor ?? AppColors.base,
                    ),
              )
            ],
          ),
        ));
  }
}

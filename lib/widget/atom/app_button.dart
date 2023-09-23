import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_style.dart';

class AppButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? fontSize;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsets padding;
  final bool enable;
  final Color buttonColor;
  final Color disabledButtonColor;
  final Color disabledTextColor;
  final Color textColor;
  final Color borderColor;
  final Color? iconColor;
  final String text;
  final Function() onTap;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final Widget? child;

  const AppButton({
    super.key,
    this.width,
    this.height,
    this.fontSize,
    this.borderRadius,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSizes.padding,
      vertical: AppSizes.padding,
    ),
    this.enable = true,
    this.buttonColor = AppColors.primary,
    this.disabledButtonColor = AppColors.baseLv4,
    this.disabledTextColor = Colors.white,
    this.textColor = Colors.white,
    this.iconColor,
    this.leftIcon,
    this.rightIcon,
    this.borderWidth,
    this.borderColor = AppColors.baseLv6,
    this.child,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: enable ? onTap : null,
        splashColor: Colors.black.withOpacity(0.06),
        splashFactory: InkRipple.splashFactory,
        highlightColor: enable ? Colors.black12 : Colors.transparent,
        borderRadius: borderRadius ?? BorderRadius.circular(100),
        child: Ink(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: enable ? buttonColor : disabledButtonColor,
            borderRadius: borderRadius ?? BorderRadius.circular(100),
            border: borderWidth != null
                ? Border.all(
                    width: borderWidth!,
                    color: borderColor,
                  )
                : null,
          ),
          child: child ??
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    leftIconWidget(),
                    textWidget(context),
                    rightIconWidget(),
                  ],
                ),
              ),
        ),
      ),
    );
  }

  Widget textWidget(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: AppTextStyle.bold(
        context,
        fontSize: fontSize ?? 16,
        color: enable ? textColor : disabledTextColor,
      ),
    );
  }

  Widget leftIconWidget() {
    if (leftIcon == null) {
      if (rightIcon != null) {
        return const SizedBox(width: 6);
      }

      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Icon(
        leftIcon,
        color: enable ? (iconColor ?? textColor) : disabledTextColor,
        size: fontSize != null ? (fontSize! + 2) : 16,
      ),
    );
  }

  Widget rightIconWidget() {
    if (rightIcon == null) {
      if (leftIcon != null) {
        return const SizedBox(width: 6);
      }

      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Icon(
        rightIcon,
        color: enable ? (iconColor ?? textColor) : disabledTextColor,
        size: fontSize != null ? (fontSize! + 2) : 16,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';

class AppCardContainer extends StatelessWidget {
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;

  const AppCardContainer({
    Key? key,
    this.backgroundColor,
    this.borderRadius,
    this.margin,
    this.padding,
    this.child,
    this.boxShadow,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(AppSizes.radius * 2),
        boxShadow: boxShadow ?? [],
        gradient: gradient,
      ),
      padding: padding ?? const EdgeInsets.all(AppSizes.padding * 1.5),
      margin: margin ?? const EdgeInsets.all(AppSizes.padding),
      child: child,
    );
  }
}

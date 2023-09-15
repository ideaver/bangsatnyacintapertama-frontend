import 'package:alvamind_library_two/app/theme/app_colors.dart';
import 'package:alvamind_library_two/app/theme/app_sizes.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final EdgeInsets? padding;
  final Color? color;
  final List<BoxShadow>? boxShadow;
  final double borderRadius;
  final Widget child;

  const AppCard({
    super.key,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSizes.padding,
      vertical: AppSizes.padding,
    ),
    this.color = AppColors.white,
    this.boxShadow,
    this.borderRadius = AppSizes.radius * 2,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}

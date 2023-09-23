import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_sizes.dart';
import '../../../app/theme/app_text_style.dart';
import '../atom/app_icon_button.dart';
import '../atom/app_image.dart';

class ProfileUser extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? image;
  final IconData? icon;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final Color? backgroundColor;
  final double? imageSize;
  final double? iconSize;
  final double? borderRadius;
  final EdgeInsets? padding;
  final void Function(bool) onTap;

  const ProfileUser({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.backgroundColor,
    this.borderRadius,
    this.image,
    this.imageSize,
    this.subtitleTextStyle,
    this.titleTextStyle,
    this.padding,
    this.iconSize,
    this.icon,
  });

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 100),
      ),
      child: Padding(
        padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: AppImage(
                image: widget.image ?? randomImage,
                borderRadius: 100,
              ),
            ),
            const SizedBox(width: AppSizes.padding / 2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: widget.titleTextStyle ??
                      AppTextStyle.bold(
                        context,
                        fontSize: 14,
                      ),
                ),
                const SizedBox(height: AppSizes.padding / 8),
                Text(
                  widget.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: widget.subtitleTextStyle ??
                      AppTextStyle.regular(
                        context,
                        fontSize: 11,
                      ),
                ),
              ],
            ),
            AppIconButton(
              icon: widget.icon ?? Icons.keyboard_arrow_down,
              iconSize: 18,
              padding: EdgeInsets.zero,
            )
          ],
        ),
      ),
    );
  }
}

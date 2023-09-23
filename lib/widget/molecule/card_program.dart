import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_sizes.dart';
import '../../../app/theme/app_text_style.dart';
import '../../app/theme/app_shadows.dart';
import '../atom/app_button.dart';
import '../atom/app_card_container.dart';
import '../atom/app_icon_button.dart';
import '../atom/app_tooltip.dart';

class CardProgram extends StatefulWidget {
  final String? title;
  final String? contentText;
  final String? contentSubtext;
  final String? bottomTitle;
  final String? bottomsubtitle;
  final String? toolTipTitle;
  final String? toolTipsubtitle;
  final String? buttonText;
  final Widget? tootipContentWidget;
  final IconData? iconProgram;
  final Color? backgroundColorIcon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? bottomTitleColor;
  final Color? bottomSubtitleColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final double? subtitleSize;
  final bool? withButton;
  final EdgeInsets? paddingToolTip;
  final EdgeInsets? padding;
  final List<BoxShadow>? boxShadow;
  final Widget? customWidgetRightIcon;
  final void Function()? onTapCard;
  final void Function()? onTapInfo;
  final void Function()? onTapButton;

  const CardProgram({
    super.key,
    this.title,
    this.contentText,
    this.contentSubtext,
    this.bottomTitle,
    this.bottomSubtitleColor,
    this.bottomTitleColor,
    this.bottomsubtitle,
    this.buttonText,
    this.iconProgram,
    this.onTapCard,
    this.onTapInfo,
    this.boxShadow,
    this.toolTipTitle,
    this.toolTipsubtitle,
    this.tootipContentWidget,
    this.paddingToolTip,
    this.backgroundColor,
    this.backgroundColorIcon,
    this.iconColor,
    this.subtitleColor,
    this.titleColor,
    this.subtitleSize,
    this.withButton = false,
    this.onTapButton,
    this.customWidgetRightIcon,
    this.padding,
  });

  @override
  State<CardProgram> createState() => _CardProgramState();
}

class _CardProgramState extends State<CardProgram> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius * 2),
        boxShadow: widget.boxShadow ?? [],
      ),
      child: Padding(
        padding: widget.padding ?? const EdgeInsets.all(AppSizes.padding * 1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIconButton(
                  icon: widget.iconProgram ?? Icons.campaign_rounded,
                  iconSize: 24,
                  iconColor: widget.iconColor,
                  backgroundColor: widget.backgroundColorIcon ?? AppColors.baseLv7,
                  padding: const EdgeInsets.all(AppSizes.padding / 1.5),
                ),
                widget.customWidgetRightIcon != null ? widget.customWidgetRightIcon! : tooltip(),
              ],
            ),
            const SizedBox(height: AppSizes.padding * 1.5),
            Text(
              widget.title ?? '',
              style: AppTextStyle.bold(
                context,
                fontSize: 18,
                color: widget.titleColor ?? AppColors.baseLv4,
              ),
            ),
            const SizedBox(height: AppSizes.padding / 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.contentText ?? '',
                  style: AppTextStyle.extraBold(
                    context,
                    fontSize: widget.subtitleSize ?? 36,
                    color: widget.subtitleColor,
                  ),
                ),
                const SizedBox(width: AppSizes.padding / 2),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    widget.contentSubtext ?? '',
                    style: AppTextStyle.bold(
                      context,
                      fontSize: 16,
                      color: widget.subtitleColor?.withOpacity(0.60) ?? AppColors.baseLv5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.padding),
            widget.bottomTitle == null && widget.bottomsubtitle == null
                ? const SizedBox.shrink()
                : Row(
                    children: [
                      Text(
                        widget.bottomTitle ?? '',
                        style: AppTextStyle.bold(
                          context,
                          fontSize: 16,
                          color: widget.bottomTitleColor ?? const Color(0xFF36D362),
                        ),
                      ),
                      const SizedBox(width: AppSizes.padding / 2),
                      Text(
                        widget.bottomsubtitle ?? '',
                        style: AppTextStyle.medium(
                          context,
                          fontSize: 16,
                          color: AppColors.baseLv5,
                        ),
                      ),
                    ],
                  ),
            widget.withButton == true
                ? AppButton(
                    text: widget.buttonText ?? '',
                    fontSize: 16,
                    buttonColor: AppColors.white,
                    textColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.padding,
                      vertical: AppSizes.padding / 1.5,
                    ),
                    onTap: widget.onTapButton ?? () {},
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget tooltip() {
    return AppTooltip(
      arrowLength: 0,
      content: Container(
        padding: widget.paddingToolTip,
        constraints: const BoxConstraints(minWidth: 250, maxWidth: 500),
        child: AppCardContainer(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(AppSizes.padding),
          boxShadow: [AppShadows.cardShadow4],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.toolTipTitle ?? '',
                style: AppTextStyle.bold(
                  context,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: AppSizes.padding / 2),
              widget.toolTipsubtitle != null
                  ? Text(
                      widget.toolTipsubtitle ?? '',
                      style: AppTextStyle.regular(
                        context,
                        fontSize: 14,
                        color: AppColors.baseLv5,
                      ),
                    )
                  : const SizedBox.shrink(),
              widget.tootipContentWidget != null ? widget.tootipContentWidget! : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
      child: Icon(
        Icons.info_outline,
        size: 20,
        color: widget.withButton == true ? AppColors.white : AppColors.baseLv5,
      ),
    );
  }
}

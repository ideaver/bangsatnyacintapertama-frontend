import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_style.dart';

class AppCheckbox extends StatelessWidget {
  final bool enable;
  final bool? value;
  final String? title;
  final Color activeColor;
  final Color fillColor;
  final TextStyle? titleStyle;
  final EdgeInsets padding;
  final Function(bool?) onChanged;

  const AppCheckbox({
    Key? key,
    this.enable = true,
    required this.value,
    this.title,
    this.activeColor = AppColors.primary,
    this.fillColor = AppColors.primary,
    this.titleStyle,
    this.padding = EdgeInsets.zero,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enable ? 1 : 0.5,
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: (val) {
                if (enable) {
                  onChanged(val);
                }
              },
              activeColor: activeColor,
            ),
            title != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      title!,
                      style: titleStyle ??
                          AppTextStyle.bold(
                            context,
                            fontSize: 14,
                          ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

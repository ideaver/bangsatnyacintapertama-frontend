import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_style.dart';

// App Progress Indicator

class AppProgressIndicator extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final double size;
  final bool showMessage;
  final String message;

  const AppProgressIndicator({
    super.key,
    this.color = AppColors.baseLv2,
    this.textColor = AppColors.baseLv2,
    this.size = 32,
    this.showMessage = true,
    this.message = 'Please wait',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(color: color),
          ),
          showMessage
              ? Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Text(
                    message,
                    style: AppTextStyle.medium(
                      context,
                      fontSize: 10,
                      color: AppColors.baseLv2,
                    ),
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

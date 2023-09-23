import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';

class AppTextFieldsWrapper extends StatelessWidget {
  final List<Widget> textFields;

  const AppTextFieldsWrapper({
    Key? key,
    required this.textFields,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: AppColors.baseLv6,
        ),
        borderRadius: BorderRadius.circular(
          AppSizes.radius,
        ),
      ),
      child: Column(
        children: [
          ...List.generate(textFields.length, (i) {
            return Column(
              children: [
                textFields[i],
                i == (textFields.length - 1)
                    ? const SizedBox.shrink()
                    : const Divider(
                        color: AppColors.baseLv6,
                        thickness: 1.5,
                        height: 0,
                      ),
              ],
            );
          })
        ],
      ),
    );
  }
}

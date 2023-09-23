
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../app/theme/app_shadows.dart';
import '../../app/theme/app_sizes.dart';

class AppDropDown extends StatefulWidget {
  final Widget? customButton;
  final ButtonStyleData? buttonStyleData;
  final DropdownStyleData? dropdownStyleData;
  final MenuItemStyleData? menuItemStyleData;
  final EdgeInsets? padding;

  final List<DropdownMenuItem<Object>>? items;
  final void Function(Object)? onChanged;

  const AppDropDown({
    super.key,
    this.customButton,
    this.buttonStyleData,
    this.dropdownStyleData,
    this.menuItemStyleData,
    this.items,
    this.onChanged,
    this.padding,
  });

  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: widget.customButton,
        buttonStyleData: widget.buttonStyleData ??
            ButtonStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
        items: widget.items,
        onChanged: (value) {
          widget.onChanged!(value!);
        },
        dropdownStyleData: widget.dropdownStyleData ??
            DropdownStyleData(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.radius * 2),
                color: Colors.white,
                boxShadow: [AppShadows.cardShadow3],
              ),
            ),
        menuItemStyleData: widget.menuItemStyleData ??
            MenuItemStyleData(
              customHeights: [...List<double>.filled((widget.items?.length ?? 0), 48)],
              padding: const EdgeInsets.only(left: 16, right: 16),
            ),
      ),
    );
  }
}

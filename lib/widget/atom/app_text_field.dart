import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_sizes.dart';
import '../../app/theme/app_text_style.dart';

enum AppTextFieldType {
  text,
  password,
  number,
  phone,
  search,
}

class AppTextField extends StatefulWidget {
  final AppTextFieldType type;
  final String? lableText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardtype;
  final bool enabled;
  final bool showSuffixButton;
  final bool showCounter;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final double borderRadius;
  final Color? fillColor;
  final Color disabledColor;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focus;

  const AppTextField({
    super.key,
    this.type = AppTextFieldType.text,
    this.lableText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardtype,
    this.enabled = true,
    this.showSuffixButton = true,
    this.showCounter = false,
    this.minLines,
    this.onTap,
    this.maxLines = 1,
    this.maxLength,
    this.borderRadius = 100,
    this.onChanged,
    this.onEditingComplete,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSizes.padding,
      vertical: AppSizes.padding / 2,
    ),
    this.contentPadding,
    this.controller,
    this.textInputType,
    this.textInputAction,
    this.inputFormatters,
    this.fillColor,
    this.disabledColor = AppColors.baseLv4,
    this.focus,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obsecureText = false;

  @override
  void initState() {
    _obsecureText = widget.type == AppTextFieldType.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.fillColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: TextField(
          controller: widget.controller,
          enabled: widget.enabled,
          obscureText: _obsecureText,
          minLines: widget.minLines,
          maxLines: widget.type == AppTextFieldType.password ? 1 : widget.maxLines,
          maxLength: widget.maxLength ?? (widget.type == AppTextFieldType.password ? 14 : widget.maxLength),
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          keyboardType: keyboardType(),
          textInputAction: widget.textInputAction,
          inputFormatters: inputFormatters(),
          focusNode: widget.focus,
          style: AppTextStyle.medium(
            context,
            color: widget.enabled ? AppColors.base : widget.disabledColor,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            counterText: widget.showCounter ? null : '',
            labelText: widget.lableText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: suffixIconWidget(),
            fillColor: widget.fillColor,
            border: InputBorder.none,
            labelStyle: AppTextStyle.medium(
              context,
              color: AppColors.baseLv4,
              fontSize: 14,
            ),
            contentPadding: widget.contentPadding ??
                const EdgeInsets.fromLTRB(
                  0,
                  AppSizes.padding,
                  AppSizes.padding / 2,
                  AppSizes.padding,
                ),
            hintText: widget.hintText,
            hintStyle: AppTextStyle.medium(
              context,
              color: AppColors.baseLv4,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  TextInputType? keyboardType() {
    if (widget.textInputType != null) {
      return widget.textInputType;
    }

    if (widget.type == AppTextFieldType.phone) {
      return TextInputType.phone;
    }

    if (widget.type == AppTextFieldType.number) {
      return TextInputType.number;
    }

    return widget.textInputType;
  }

  List<TextInputFormatter>? inputFormatters() {
    if (widget.inputFormatters != null) {
      return widget.inputFormatters;
    }

    if (widget.type == AppTextFieldType.phone) {
      return [FilteringTextInputFormatter.digitsOnly];
    }

    if (widget.type == AppTextFieldType.number) {
      return [FilteringTextInputFormatter.digitsOnly];
    }

    return widget.inputFormatters;
  }

  Widget? suffixIconWidget() {
    if (widget.type == AppTextFieldType.password && widget.showSuffixButton) {
      return textVisibilityIconButton();
    }

    if (widget.type == AppTextFieldType.search && widget.showSuffixButton) {
      return cancelSearchButton();
    }

    return widget.suffixIcon;
  }

  Widget textVisibilityIconButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _obsecureText = !_obsecureText;
        });
      },
      child: Icon(
        _obsecureText ? Icons.visibility_off_rounded : Icons.remove_red_eye_rounded,
        // color: AppColors.baseLv5,
        // size: widget.iconsSize,
      ),
    );
  }

  Widget cancelSearchButton() {
    return GestureDetector(
      onTap: () {
        widget.focus?.unfocus();
        widget.controller?.clear();
      },
      child: const Icon(
        Icons.cancel_rounded,
        color: AppColors.baseLv5,
        size: 24,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MenuItemModel {
  final String? value;
  final String? text;
  final Widget? icon;
  final Function()? onTap;
  final Widget? child;

  MenuItemModel({
    this.value,
    this.text,
    this.icon,
    this.onTap,
    this.child,
  });
}

import 'package:flutter/material.dart';

class SideBarMenuModel {
  String title;
  IconData icon;
  bool showDivider;

  SideBarMenuModel({
    required this.title,
    required this.icon,
    this.showDivider = false,
  });
}

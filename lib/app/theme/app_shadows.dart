import 'package:flutter/material.dart';

import 'app_colors.dart';

// App Colors
class AppShadows {
  // This class is not meant to be instatiated or extended; this constructor
  // prevents instantiation and extension.
  AppShadows._();

  static final cardShadow1 = BoxShadow(
    color: AppColors.black.withOpacity(0.08),
    offset: const Offset(0, 4),
    blurRadius: 60,
  );

  static final cardShadow2 = BoxShadow(
    color: AppColors.black.withOpacity(0.05),
    offset: const Offset(0, 4),
    blurRadius: 60,
  );

  static final cardShadow3 = BoxShadow(
    color: AppColors.black.withOpacity(0.08),
    offset: const Offset(0, 20),
    blurRadius: 100,
  );

  static final cardShadow4 = BoxShadow(
    color: AppColors.black.withOpacity(0.45),
    offset: const Offset(0, 20),
    blurRadius: 100,
  );

  static final shadow1 = BoxShadow(
    color: AppColors.primary.withOpacity(0.25),
    offset: const Offset(4, 8),
    blurRadius: 24,
  );

  static final shadow2 = BoxShadow(
    color: AppColors.primary.withOpacity(0.20),
    offset: const Offset(4, 12),
    blurRadius: 32,
  );

  static final shadow3 = BoxShadow(
    color: AppColors.primary.withOpacity(0.20),
    offset: const Offset(4, 16),
    blurRadius: 32,
  );

  static final shadow4 = BoxShadow(
    color: AppColors.black.withOpacity(0.08),
    offset: const Offset(1, 1),
    blurRadius: 10.0,
    spreadRadius: 2.0,
  );

  static final bottomNav = BoxShadow(
    color: AppColors.black.withOpacity(0.08),
    offset: const Offset(0, -4),
    blurRadius: 60,
  );
}

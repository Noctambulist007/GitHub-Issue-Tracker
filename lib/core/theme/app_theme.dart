import 'package:flutter/material.dart';
import 'package:github_issue_tracker/core/utils/constants.dart';

class AppTheme {
  static final light = ThemeData.light().copyWith(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
  );

  static final dark = ThemeData.dark().copyWith(
    primaryColor: AppColors.primaryColor.withOpacity(1),
    scaffoldBackgroundColor: const Color(0xFF333333),
  );
}

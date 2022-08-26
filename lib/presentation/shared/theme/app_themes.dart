import 'package:flutter/material.dart';
import 'package:github_repo_plus/presentation/shared/theme/colors.dart';

class AppThemes {
  static ThemeData get darkTheme {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: ThemeColors.darkBlue,
        actionsIconTheme: IconThemeData(color: ThemeColors.darkBlue),
      ),
      canvasColor: ThemeColors.darkBlue,
      colorScheme: const ColorScheme.dark(primary: ThemeColors.darkBlue),
      // iconTheme: IconThemeData(color: ThemeColors.white),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

ButtonStyle styleElevated() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      AppColors.accentColor,
    ),
  );
}

/// Convenience class to access application colors.
abstract class AppColors {
  /// Dark background color.
  static const Color backgroundColor = Color(0xFF191D1F);

  /// Slightly lighter version of [backgroundColor].
  static const Color backgroundFadedColor = Color(0xFF191B1C);

  /// Color used for cards and surfaces.
  static const Color cardColor = Color(0xFF1F2426);

  /// Accent color used in the application.
  static const Color accentColor = Color(0xFFef8354);
}

abstract class TextStyles {
  static const TextStyle heading =
      TextStyle(fontSize: 25, fontWeight: FontWeight.w600);

  static const TextStyle subHeading =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  static const TextStyle text = TextStyle(
    fontSize: 15,
  );
  static const TextStyle subText = TextStyle(
    fontSize: 15,
  );
}

TextButton saveBtn(VoidCallback func) {
  return TextButton(
      onPressed: func,
      child: const Text(
        'Save',
        style: TextStyle(color: AppColors.accentColor),
      ));
}

TextButton cancelBtn(VoidCallback func) {
  return TextButton(
      onPressed: func,
      child: const Text(
        'Cancel',
        style: TextStyle(color: Colors.red),
      ));
}
TextButton deleteBtn(VoidCallback func) {
  return TextButton(
      onPressed: func,
      child: const Text(
        'Delete',
        style: TextStyle(color: Colors.red),
      ));
}

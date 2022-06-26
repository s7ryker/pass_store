import 'package:flutter/material.dart';
import 'package:pass_store/utils/constants.dart';
import 'package:pass_store/utils/theme_data.dart';

AppBar customAppbar() {
  return AppBar(
    title: const Text(PASSSTORE),
    backgroundColor: AppColors.accentColor,
  );
}

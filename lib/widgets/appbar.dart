import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pass_store/model/item_model.dart';
import 'package:pass_store/provider/home.dart';
import 'package:pass_store/utils/constants.dart';
import 'package:pass_store/utils/theme_data.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

AppBar customAppbar(BuildContext context) {
  return AppBar(
    title: const Text(PASSSTORE),
    backgroundColor: AppColors.accentColor,
    actions: [
      PopupMenuButton<int>(
        onSelected: (item) async => onSelected(context, item),
        itemBuilder: (context) => [
          const PopupMenuItem<int>(
            value: 0,
            child: Text('Back Up'),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem<int>(
            value: 1,
            child: Text('Restore'),
          ),
        ],
      ),
    ],
  );
}

void onSelected(BuildContext context, int item) async {
  log('onSelected');
  log(item.toString());
  switch (item) {
    case 0:
      log('backup');

      try {
        await Provider.of<Home>(context, listen: false).generateCsv();
      } on FileSystemException {
        showDialog(
          context: context,
          builder: (constex) => AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Permission required. Please allow storage permission for $PASSSTORE and try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (constex) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Something went wrong.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      }

      break;
    case 1:
      log('restore');
      try {
        await Provider.of<Home>(context, listen: false).logData();
      } on FileSystemException {
        showDialog(
          context: context,
          builder: (constex) => AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Permission required. Please allow storage permission for $PASSSTORE and try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (constex) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Something went wrong.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      }

      break;
  }
}

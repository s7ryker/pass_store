import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pass_store/boxes.dart';
import 'package:pass_store/model/item_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Home with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get getItems {
    return [..._items];
  }

  void setItems() {
    Future.delayed(Duration.zero, () {
      //your code goes here
      final box = Boxes.getItems();
      _items = box.values.toList();
      notifyListeners();
    });
  }

  Future<void> setSecurity()async {

  }

  void addItem(String account, String userName, String password) {
    final id = DateTime.now().toString();
    final item = Item()
      ..id = id
      ..accountName = account
      ..userName = userName
      ..password = password;

    final box = Boxes.getItems();
    box.add(item);
    _items = box.values.toList();
    notifyListeners();
  }

  void backup() async {
    final box = Boxes.getItems();
  }

  void editItem(
    Item item,
    String account,
    String userName,
    String password,
  ) {
    item.accountName = account;
    item.userName = userName;
    item.password = password;
    item.save();
    final box = Boxes.getItems();
    _items = box.values.toList();
    notifyListeners();
  }

  void deleteItem(Item item) {
    item.delete();
    final box = Boxes.getItems();
    _items = box.values.toList();
    notifyListeners();
  }

  generateCsv() async {
    List<List<String>> list = [
      ['Id', 'Account', 'Username', 'Password'],
    ];
    for (var element in _items) {
      list.add([
        element.id,
        element.accountName,
        element.userName,
        element.password
      ]);
    }

    String csvData = const ListToCsvConverter().convert(list);
    PermissionStatus permission = await Permission.storage.request();
    if (permission.isGranted) {
      final path =
          "/storage/emulated/0/Download/PassStore-Backup-${DateTime.now()}.csv";
      log(path);
      final File file = await File(path).create();

      await file.writeAsString(csvData);
    } else if (permission.isPermanentlyDenied) {
      throw const FileSystemException('FileSystemException');
    } else if (permission.isDenied) {
      throw const FileSystemException('FileSystemException');
    } else {
      throw Exception();
    }
  }

  Future<List<List<dynamic>>> loadingCsvData() async {
    PermissionStatus permission = await Permission.storage.request();
    if (permission.isGranted) {
      final result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['csv'],
        type: FileType.custom,
      );

      if (result == null) {
        return [];
      } else {
        final path = result.files.first.path;
        final csvFile = File(path!).openRead();
        return await csvFile
            .transform(utf8.decoder)
            .transform(
              const CsvToListConverter(),
            )
            .toList();
      }
    } else if (permission.isPermanentlyDenied) {
      throw const FileSystemException('FileSystemException');
    } else if (permission.isDenied) {
      throw const FileSystemException('FileSystemException');
    } else {
      throw Exception();
    }
  }

  logData() async {
    var list = await loadingCsvData();
    if (list.isEmpty) return;
    log(list.toString());
    list.removeAt(0);
    List<Item> data = [];
    for (var element in list) {
      log(element.toString());
      final ite = Item()
        ..id = element[0]
        ..accountName = element[1]
        ..userName = element[2]
        ..password = element[3];
      data.add(ite);
    }
    final box = Boxes.getItems();
    for (var element in data) {
      box.add(element);
    }
    _items = box.values.toList();
    notifyListeners();
  }
}

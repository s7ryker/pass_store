

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pass_store/boxes.dart';
import 'package:pass_store/model/item_model.dart';

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
}

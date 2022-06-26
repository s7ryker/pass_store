import 'package:hive/hive.dart';

import 'model/item_model.dart';

class Boxes {
  static Box<Item> getItems() => Hive.box<Item>('items');
}

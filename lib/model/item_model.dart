import 'package:hive/hive.dart';
part 'item_model.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String accountName;
  @HiveField(2)
  late String userName;
  @HiveField(3)
  late String password;
}

import 'package:shopping_list/data/list/shopping_item.dart';
import 'package:hive/hive.dart';

part 'shopping_list.g.dart';

@HiveType(typeId: 0)
class ShoppingList {
  @HiveField(0)
  String name = "";
  @HiveField(1)
  List<ShoppingItem> items = [];

  ShoppingList(this.name);

  int boughtItemsCount() {
    int sum = 0;

    for (var element in items) {
      if (element.bought == 1) ++sum;
    }

    return sum;
  }
}

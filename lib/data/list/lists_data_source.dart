import 'package:shopping_list/data/list/shopping_list.dart';
import 'package:hive/hive.dart';

class ListsDataSource {
  static String fileName = 'lists';

  ListsDataSource();

  Future<List<ShoppingList>> getLists() async {
    await Hive.openBox(fileName);
    return Hive.box(fileName).values.toList().cast();
  }

  void add(ShoppingList list) async {
    Hive.box(fileName).put(list.name, list);
  }

  void modify(ShoppingList list, String oldName) {
    Hive.box(fileName).delete(oldName);
    Hive.box(fileName).put(list.name, list);
  }

  void delete(ShoppingList list) {
    Hive.box(fileName).delete(list.name);
  }
}

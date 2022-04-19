import 'package:flutter/material.dart';
import 'package:shopping_list/data/list/lists_data_source.dart';
import 'package:shopping_list/data/list/shopping_list.dart';

class ListsProvider extends InheritedWidget {
  ListsProvider({
    Key? key,
    required Widget child,
    required this.source,
  }) : super(
          key: key,
          child: child,
        );

  final ListsDataSource source;
  bool _modified = false;

  @override
  bool updateShouldNotify(ListsProvider oldWidget) {
    if (_modified) {
      _modified = false;
      return true;
    }
    return false;
  }

  Future<List<ShoppingList>> getLists() async => await source.getLists();

  void add(ShoppingList list) {
    source.add(list);
    _modified = true;
  }

  // requires modified list and list's name before modification
  void modify(ShoppingList list, String oldName) {
    source.modify(list, oldName);
    _modified = true;
  }

  void delete(ShoppingList list) {
    source.delete(list);
    _modified = true;
  }

  static ListsProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ListsProvider>();
}

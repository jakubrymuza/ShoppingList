import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/data/list/lists_provider.dart';
import 'package:shopping_list/data/list/shopping_list.dart';
import 'package:shopping_list/screens/product_screen/product_screen.dart';
import 'package:shopping_list/screens/shopping_list_screen/list_item_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShoppingListScreen extends StatefulWidget {
  final ShoppingList list;

  const ShoppingListScreen({Key? key, required this.list}) : super(key: key);

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.list.name),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        itemCount: widget.list.items.length,
        itemBuilder: (context, index) {
          return ListItem(
            shoppingItem: widget.list.items[index],
            onDelete: (item) {
              setState(() {
                widget.list.items.remove(item);
                ListsProvider.of(context)!
                    .modify(widget.list, widget.list.name);
              });
            },
          );
        },
        separatorBuilder: (context, _) {
          return const Divider(height: 10, thickness: 0);
        },
      ),
      floatingActionButton: _buildButton(),
    );
  }

  Widget _buildButton() {
    return OpenContainer(
      openColor: Theme.of(context).scaffoldBackgroundColor,
      closedColor: Theme.of(context).scaffoldBackgroundColor,
      openElevation: 0.0,
      closedElevation: 5.0,
      transitionDuration: const Duration(milliseconds: 300),
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      closedBuilder: (context, openContainer) {
        return FloatingActionButton(
            onPressed: openContainer,
            tooltip: AppLocalizations.of(context)!.addItemTooltip,
            child: const Icon(Icons.add));
      },
      openBuilder: (context, closeContainer) {
        return ProductScreen(onAdd: (newItem) {
          setState(() {
            widget.list.items.add(newItem);
            ListsProvider.of(context)!.modify(widget.list, widget.list.name);
          });
          closeContainer();
        });
      },
    );
  }
}

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/data/list/shopping_list.dart';
import 'package:shopping_list/screens/shopping_list_screen/shopping_list_screen.dart';

class ShoppingListWidget extends StatefulWidget {
  final ShoppingList list;
  final ValueChanged<ShoppingList> onDelete;
  final ValueChanged<ShoppingList> onRename;

  const ShoppingListWidget(
      {Key? key,
      required this.list,
      required this.onDelete,
      required this.onRename})
      : super(key: key);

  @override
  State<ShoppingListWidget> createState() => _ShoppingListWidgetState();
}

// showing single shopping list signature
class _ShoppingListWidgetState extends State<ShoppingListWidget> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openColor: Theme.of(context).scaffoldBackgroundColor,
      closedColor: Theme.of(context).scaffoldBackgroundColor,
      openElevation: 0.0,
      closedElevation: 5.0,
      transitionDuration: const Duration(milliseconds: 300),
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      closedBuilder: (context, openContainer) {
        return InkWell(
          onTap: openContainer,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 8),
                Text(widget.list.name),
                // const SizedBox(width: 14),
                // Text(
                //     "${widget.list.boughtItemsCount()}/${widget.list.items.length}"),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    widget.onRename(widget.list);
                  },
                  child: const Icon(Icons.edit),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    widget.onDelete(widget.list);
                  },
                  child: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        );
      },
      openBuilder: (context, closeContainer) {
        return ShoppingListScreen(list: widget.list);
      },
    );
  }
}

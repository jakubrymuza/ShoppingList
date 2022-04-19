import 'package:flutter/material.dart';
import 'package:shopping_list/data/list/shopping_item.dart';
import 'package:shopping_list/utils/quantity_dialog.dart';
import 'package:shopping_list/utils/open_animated_dialog.dart';

class ListItem extends StatefulWidget {
  final ShoppingItem shoppingItem;
  final ValueChanged<ShoppingItem> onDelete;

  const ListItem({Key? key, required this.shoppingItem, required this.onDelete})
      : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
              value: widget.shoppingItem.bought == 1 ? true : false,
              onChanged: (value) {
                setState(() {
                  if (value != null) widget.shoppingItem.bought = value ? 1 : 0;
                });
              }),
          const SizedBox(width: 8),
          Text(widget.shoppingItem.product.name),
          const SizedBox(width: 16),
          TextButton(
              onPressed: () async {
                final quantity = await OpenAnimatedDialog.showDialog(
                    context, const QuantityDialog());

                setState(() {
                  widget.shoppingItem.quantity = quantity;
                });
              },
              child: Text(widget.shoppingItem.quantity.toString(),
                  style: Theme.of(context).textTheme.bodyText2)),
          const Spacer(),
          GestureDetector(
            onTap: () {
              widget.onDelete(widget.shoppingItem);
            },
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

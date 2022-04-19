import 'package:flutter/material.dart';
import 'package:shopping_list/data/product/product.dart';
import 'package:shopping_list/data/list/shopping_item.dart';
import 'package:shopping_list/utils/quantity_dialog.dart';
import 'package:shopping_list/utils/open_animated_dialog.dart';

class ProductWidget extends StatefulWidget {
  final ValueChanged<ShoppingItem> onAdd;
  final Product product;

  const ProductWidget({Key? key, required this.product, required this.onAdd})
      : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

// single product on the product list
class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final quantity = await OpenAnimatedDialog.showDialog(
            context, const QuantityDialog());

        widget.onAdd(ShoppingItem(product: widget.product, quantity: quantity));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow.shade600,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.product.name),
            const SizedBox(width: 16),
            Text(widget.product.getCathegory().toVerbose(context)),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

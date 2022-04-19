import 'package:flutter/material.dart';
import 'package:shopping_list/data/product/product.dart';
import 'package:shopping_list/screens/product_screen/product_widget.dart';
import 'package:shopping_list/data/list/shopping_item.dart';

class CathegoryWidget extends StatefulWidget {
  final Cathegory cathegory;
  final List<Product> products;
  final ValueChanged<ShoppingItem> onAdd;

  const CathegoryWidget(
      {Key? key,
      required this.cathegory,
      required this.products,
      required this.onAdd})
      : super(key: key);

  @override
  State<CathegoryWidget> createState() => _CathegoryWidgetState();
}

class _CathegoryWidgetState extends State<CathegoryWidget> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 300),
        crossFadeState:
            expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        firstChild: _buildCathegoryTile(),
        secondChild: Column(
          children: _getChildren()..insert(0, _buildCathegoryTile())..insert(1, const Divider(height: 10, thickness: 0)),
        ),
      ),
    );
  }

  Widget _buildCathegoryTile() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Center(child: Text(widget.cathegory.toVerbose(context).toUpperCase())),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
    );
  }

  List<Widget> _getChildren() {
    final list = List<Widget>.empty(growable: true);

    for (var product in widget.products) {
      if (product.getCathegory() == widget.cathegory) {
        list.add(ProductWidget(
          product: product,
          onAdd: widget.onAdd,
        ));
        list.add(const Divider(height: 10, thickness: 0));
      }
    }
    return list;
  }
}

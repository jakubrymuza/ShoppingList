import 'package:flutter/material.dart';
import 'package:shopping_list/data/product/product.dart';
import 'package:shopping_list/data/product/products_data_source.dart';

class ProductsProvider extends InheritedWidget {
  ProductsProvider({
    Key? key,
    required Widget child,
    required this.source,
  }) : super(
          key: key,
          child: child,
        );

  final ProductsDataSource source;
  bool _modified = false;

  @override
  bool updateShouldNotify(ProductsProvider oldWidget) {
    if (_modified) {
      _modified = false;
      return true;
    }
    return false;
  }

  Future<List<Product>> getLists() async => await source.getProducts();

  void add(Product product) {
    source.add(product);
    _modified = true;
  }

  static ProductsProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ProductsProvider>();
}

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/data/list/shopping_item.dart';
import 'package:shopping_list/data/product/product.dart';
import 'package:shopping_list/screens/product_screen/product_widget.dart';
import 'package:shopping_list/screens/new_product_screen/new_product_screen.dart';
import 'package:shopping_list/data/product/products_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopping_list/screens/product_screen/cathegory_widget.dart';

class ProductScreen extends StatefulWidget {
  final ValueChanged<ShoppingItem> onAdd;
  const ProductScreen({Key? key, required this.onAdd}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

// list of existing products to choose from
class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _controller = TextEditingController();
  late List<Product> _products;
  List<Product> _filteredProducts = [];
  bool _isFiltered = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
        future: ProductsProvider.of(context)!.getLists(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _products = snapshot.data!
              ..sort((a, b) => a.name.compareTo(b.name));
            return _buildScaffold();
          }

          return const Center(child: CircularProgressIndicator());
        });
  }

  Scaffold _buildScaffold() {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _isFiltered ? _buildFilteredList() : _buildCathegoryList(),

      // button for adding new product
      floatingActionButton: OpenContainer(
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
              tooltip: AppLocalizations.of(context)!.addProductTooltip,
              child: const Icon(Icons.add));
        },
        openBuilder: (context, closeContainer) {
          return NewProductScreen(
            onAdd: (newProduct) {
              setState(() {
                ProductsProvider.of(context)!.add(newProduct);
              });
            },
            closeContainer: closeContainer,
          );
        },
      ),
    );
  }

  Widget _buildFilteredList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        return ProductWidget(
          product: _filteredProducts[index],
          onAdd: widget.onAdd,
        );
      },
      separatorBuilder: (context, _) {
        return const Divider(height: 10, thickness: 0);
      },
    );
  }

  Widget _buildCathegoryList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      itemCount: Cathegory.values.length,
      itemBuilder: (context, index) {
        return CathegoryWidget(cathegory: Cathegory.values[index], products: _products, onAdd: widget.onAdd,);
      },
      separatorBuilder: (context, _) {
        return const Divider(height: 10, thickness: 0);
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.productsScreenTitle),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: TextField(
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.searchHintText),
                  controller: _controller,
                  textInputAction: TextInputAction.search,
                  onChanged: (x) {
                    _search();
                  },
                ),
              ),
              GestureDetector(
                onTap: _search,
                child: const Icon(Icons.search),
              )
            ],
          ),
        ),
      ],
    );
  }

  void _search() {
    if (_controller.text.isEmpty) {
      setState(() {
        _isFiltered = false;
      });
      return;
    }

    final pattern = _controller.text.toLowerCase();
    final List<Product> newProducts = [];

    for (var product in _products) {
      final name = product.name.toLowerCase();

      if (name.contains(pattern)) {
        newProducts.add(product);
      }
    }

    setState(() {
      _filteredProducts = newProducts;
      _isFiltered = true;
    });
  }
}

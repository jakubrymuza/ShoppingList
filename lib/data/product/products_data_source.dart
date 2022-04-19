import 'package:shopping_list/data/product/product.dart';
import 'package:hive/hive.dart';

class ProductsDataSource {
  static String fileName = 'products';

  ProductsDataSource();

  Future<List<Product>> getProducts() async {
    await Hive.openBox(fileName);
    return _predefinedProducts + Hive.box(fileName).values.toList().cast();
  }

  void add(Product product) async {
    Hive.box(fileName).put(product.name, product);
  }
}

// TODO: more products
var _predefinedProducts = [
  Product(name: 'chleb', cathegoryID: Cathegory.food.index),
  Product(name: 'bulki', cathegoryID: Cathegory.food.index),
  Product(name: 'coca-cola', cathegoryID: Cathegory.beverages.index),
  Product(name: 'spinacze', cathegoryID: Cathegory.officeSupplies.index),
  Product(name: 'papier', cathegoryID: Cathegory.officeSupplies.index),
  Product(name: 'poduszka', cathegoryID: Cathegory.other.index),
];

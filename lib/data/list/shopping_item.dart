import 'package:shopping_list/data/product/product.dart';
import 'package:hive/hive.dart';

part 'shopping_item.g.dart';

@HiveType(typeId: 1)
class ShoppingItem extends HiveObject {
  @HiveField(0)
  final Product product;
  @HiveField(1)
  int quantity;
  @HiveField(2)
  int bought = 0;

  ShoppingItem({required this.product, this.quantity = 0});
}

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 2)
class Product extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  int cathegoryID; // storing cathegory as enum would require another HiveType, it's easier to convert to int

  Cathegory getCathegory() => Cathegory.values[cathegoryID];

  void setCathegory(Cathegory cathegory) {
    cathegoryID = cathegory.index;
  }

  Product({required this.name, required this.cathegoryID});
}

// TODO: more cathegories
enum Cathegory { food, beverages, officeSupplies, other }

// gets localized name of the cathegory
extension ParseToString on Cathegory {
  String toVerbose(BuildContext context) {
    switch (this) {
      case Cathegory.food:
        return AppLocalizations.of(context)!.foodCatheogryText;
      case Cathegory.beverages:
        return AppLocalizations.of(context)!.beveragesCatheogryText;
      case Cathegory.officeSupplies:
        return AppLocalizations.of(context)!.officeSuppliesCatheogryText;
      case Cathegory.other:
        return AppLocalizations.of(context)!.otherCatheogryText;
    }
  }
}

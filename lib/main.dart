import 'package:flutter/material.dart';
import 'package:shopping_list/data/list/lists_provider.dart';
import 'package:shopping_list/screens/home_screen/home_screen.dart';
import 'package:shopping_list/data/list/shopping_list.dart';
import 'package:shopping_list/screens/shopping_list_screen/shopping_list_screen.dart';
import 'package:shopping_list/data/list/lists_data_source.dart';
import 'package:shopping_list/data/product/products_data_source.dart';
import 'package:shopping_list/data/product/products_provider.dart';
import 'package:shopping_list/data/product/product.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:shopping_list/data/list/shopping_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  } catch (e) {
    //print(e);
  }

  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(ShoppingItemAdapter());
  Hive.registerAdapter(ShoppingListAdapter());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isList = false;
  final _listsDataSource = ListsDataSource();
  final _productsDataSource = ProductsDataSource();
  ShoppingList? selectedList;

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProductsProvider(
      source: _productsDataSource,
      child: ListsProvider(
        source: _listsDataSource,
        child: MaterialApp(
          title: 'Shopping List App',
          theme: _getTheme(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('pl', ''),
          ],
          home: _buildNavigator(),
        ),
      ),
    );
  }

  ThemeData _getTheme() {
    return ThemeData(
      primarySwatch: Colors.brown,
      primaryColor: Colors.orange.shade300,
      scaffoldBackgroundColor: Colors.yellow.shade100,
      textTheme: const TextTheme(
          bodyText1: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Calibri'),
          bodyText2: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Calibri')),
    );
  }

  Navigator _buildNavigator() {
    return Navigator(
      pages: [
        const MaterialPage(
          key: ValueKey("HomeScreen"),
          child: HomeScreen(),
        ),
        if (selectedList != null)
          MaterialPage(
            key: ValueKey(selectedList!.name),
            child: ShoppingListScreen(
              list: selectedList!,
            ),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        setState(() {
          if (selectedList != null) {
            selectedList = null;
          } else {
            isList = false;
          }
        });

        return true;
      },
    );
  }
}

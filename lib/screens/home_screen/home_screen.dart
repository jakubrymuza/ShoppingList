import 'package:flutter/material.dart';
import 'package:shopping_list/data/list/shopping_list.dart';
import 'package:shopping_list/utils/name_dialog.dart';
import 'package:shopping_list/screens/shopping_list_screen/shopping_list_screen.dart';
import 'package:shopping_list/data/list/lists_provider.dart';
import 'package:shopping_list/screens/home_screen/shopping_list_widget.dart';
import 'package:animations/animations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopping_list/utils/open_animated_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// showing list of shopping lists
class _HomeScreenState extends State<HomeScreen> {
  late List<ShoppingList> _lists;
  ShoppingList? newList;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ShoppingList>>(
        future: ListsProvider.of(context)!.getLists(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _lists = snapshot.data!;
            return _buildScaffold();
          }

          return Scaffold(
            appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.homeScreenTitle)),
            body: const Center(child: CircularProgressIndicator()),
          );
        });
  }

  Scaffold _buildScaffold() {
    return Scaffold(
      appBar:
          AppBar(title: Text(AppLocalizations.of(context)!.homeScreenTitle)),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        itemCount: _lists.length,
        itemBuilder: (context, index) {
          return ShoppingListWidget(
            list: _lists[index],
            onDelete: (dList) {
              setState(() {
                ListsProvider.of(context)!.delete(dList);
              });
            },
            onRename: _renameList,
          );
        },
        separatorBuilder: (context, _) {
          return const Divider(height: 10, thickness: 0);
        },
      ),
      floatingActionButton: _buildButton(),
    );
  }

  // button for adding new list
  Widget _buildButton() {
    return OpenContainer(
      openColor: Theme.of(context).scaffoldBackgroundColor,
      closedColor: Theme.of(context).scaffoldBackgroundColor,
      openElevation: 0.0,
      closedElevation: 5.0,
      transitionDuration: const Duration(milliseconds: 300),
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      closedBuilder: (_, openContainer) {
        return FloatingActionButton(
            onPressed: () async {
              final name = await OpenAnimatedDialog.showDialog(
                  context, const NameDialog());

              newList = ShoppingList(name);

              setState(() {
                ListsProvider.of(context)!.add(newList!);
              });

              openContainer();
            },
            tooltip: AppLocalizations.of(context)!.addListTooltip,
            child: const Icon(Icons.add));
      },
      openBuilder: (_, closeContainer) {
        return ShoppingListScreen(
          list: newList!,
        );
      },
    );
  }

  void _renameList(ShoppingList rList) async {
    final newName =
        await OpenAnimatedDialog.showDialog(context, const NameDialog());
    final oldName = rList.name;

    setState(() {
      rList.name = newName;
      ListsProvider.of(context)!.modify(rList, oldName);
    });
  }
}

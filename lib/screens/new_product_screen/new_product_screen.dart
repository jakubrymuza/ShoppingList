import 'package:flutter/material.dart';
import 'package:shopping_list/data/product/product.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewProductScreen extends StatefulWidget {
  final ValueChanged<Product> onAdd;
  final Function closeContainer;
  const NewProductScreen(
      {Key? key, required this.onAdd, required this.closeContainer})
      : super(key: key);

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

// form for creating new products
class _NewProductScreenState extends State<NewProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _name;
  Cathegory _cathegory = Cathegory.other;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.newProductScreenTitle)),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildName(),
              _buildCathegory(),
              const SizedBox(height: 100),
              ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    _formKey.currentState?.save();

                    widget.onAdd(
                        Product(name: _name!, cathegoryID: _cathegory.index));

                    widget.closeContainer();
                  },
                  child: Text(AppLocalizations.of(context)!.submit)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.productNameHintText),
      validator: (String? value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context)!.emptyNameValidationError;
        }
      },
      onSaved: (String? value) {
        _name = value;
      },
    );
  }

  Widget _buildCathegory() {
    return DropdownButtonFormField(
      dropdownColor: Theme.of(context).primaryColor,
      items: _dropdownItems,
      value: _cathegory.index.toString(),
      onChanged: (String? value) {
        final index = int.parse(value!); // should always succeed
        _cathegory = Cathegory.values[index];
      },
    );
  }

  List<DropdownMenuItem<String>> get _dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [];

    for (var value in Cathegory.values) {
      menuItems.add(DropdownMenuItem(
          child: Text(value.toVerbose(context)),
          value: value.index.toString()));
    }
    return menuItems;
  }
}

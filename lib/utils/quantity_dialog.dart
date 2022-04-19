import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// dialog for entering product quantity
class QuantityDialog extends StatefulWidget {
  const QuantityDialog({Key? key}) : super(key: key);

  @override
  State<QuantityDialog> createState() => _QuantityDialogState();
}

class _QuantityDialogState extends State<QuantityDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.quantityDialogText),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.quantityHintText),
        controller: _controller,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        onSubmitted: (x) {
          _submit();
        },
      ),
      actions: [
        TextButton(
          onPressed: _submit,
          child: Text(AppLocalizations.of(context)!.dialogSubmitText),
        ),
      ],
    );
  }

  void _submit() {
    var value = int.tryParse(_controller.text);
    if (value != null) {
      Navigator.of(context).pop(value);
    }
  }
}

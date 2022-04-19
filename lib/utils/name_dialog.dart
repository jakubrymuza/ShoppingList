import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// dialog for entering a name
class NameDialog extends StatefulWidget {
  const NameDialog({Key? key}) : super(key: key);

  @override
  State<NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<NameDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.nameDialogText),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.nameHintText),
        controller: _controller,
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
    if (_controller.text.isNotEmpty) {
      Navigator.of(context).pop(_controller.text);
    }
  }
}

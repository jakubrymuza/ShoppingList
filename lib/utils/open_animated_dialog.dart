import 'package:flutter/material.dart';

// shows dialog with opacity animation
class OpenAnimatedDialog {
  static Future<dynamic> showDialog(BuildContext context, Widget dialog) {
    return showGeneralDialog(
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return dialog;
        },
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.4),
        barrierLabel: '',
        transitionBuilder: (context, anim1, anim2, child) {
          return Opacity(
            opacity: anim1.value,
            child: dialog,
          );
        },
        transitionDuration: const Duration(milliseconds: 300));
  }
}

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class Toast {
  final Color foreground = Colors.white;
  final Color background;
  final String text;

  Toast.success(this.text) : background = Colors.green.shade600 {
    _show();
  }

  Toast.error(this.text) : background = Colors.red {
    _show();
  }

  _show() {
    BotToast.showNotification(
      backgroundColor: background,
      title: (_) => Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 14, color: foreground, fontWeight: FontWeight.bold),
      ),
      duration: const Duration(seconds: 5),
    );
  }
}

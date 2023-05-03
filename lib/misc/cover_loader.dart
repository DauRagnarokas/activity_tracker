import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class CoverLoader {
  static final UniqueKey key = UniqueKey();

  static show() {
    BotToast.showEnhancedWidget(
      key: key,
      allowClick: false,
      toastBuilder: (_) => Container(
        color: Colors.black.withOpacity(0.5),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  static remove(){
    BotToast.remove(key);
  }
}

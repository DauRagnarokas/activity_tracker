import 'package:flutter/material.dart';

class PopupItem {
  PopupItem({
    required this.text,
    required this.iconData,
    this.onPressed,
    this.isDanger = false,
  });

  final String text;
  final IconData iconData;
  final VoidCallback? onPressed;
  final bool isDanger;
}

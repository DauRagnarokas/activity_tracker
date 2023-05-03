import 'package:flutter/material.dart';

class SizedSpacer extends StatelessWidget {
  final double? width;
  final double? height;

  const SizedSpacer.vertical([double this.height = 16]) : width = 0;

  const SizedSpacer.horizontal([double this.width = 16]) : height = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}

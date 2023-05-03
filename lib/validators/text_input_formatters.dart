import 'package:flutter/services.dart';

class BetweenZeroAndOneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    text = text.replaceFirst(',', '.');
    final oldValueFormatted = oldValue.text.replaceFirst(',', '.');
    text = RegExp(r'^$|0\.?\d*|1$').stringMatch(text) ?? oldValueFormatted;
    if (RegExp(r'^0[^.]$').stringMatch(text) != null) {
      text = oldValueFormatted;
    }
    return newValue.copyWith(
        text: text, selection: TextSelection.collapsed(offset: text.length));
  }
}

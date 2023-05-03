import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum FieldType { text, slider, int, double, dropdown }

@immutable
class FieldProps {
  final String name;
  final String label;
  final FieldType type;
  final String? helperText;
  final String? hintText;
  final FormControl formControl;

  const FieldProps({
    required this.name,
    required this.label,
    required this.type,
    required this.formControl,
    this.helperText,
    this.hintText,
  });
}

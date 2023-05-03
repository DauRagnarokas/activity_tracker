import 'package:activity_tracker/models/field_props.dart';
import 'package:activity_tracker/widgets/dropdown_field.dart';
import 'package:activity_tracker/widgets/range_slider_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../validators/text_input_formatters.dart';

class InputField extends StatelessWidget {
  final FieldProps field;
  final bool isLast;

  const InputField({
    super.key,
    required this.field,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    switch (field.type) {
      case FieldType.text:
        return _buildTextField();
      case FieldType.slider:
        return RangeSliderField(field: field);
      case FieldType.int:
        return _buildIntField();
      case FieldType.double:
        return _buildDoubleField();
      case FieldType.dropdown:
        return DropDownField(field: field);
    }
  }

  Widget _buildTextField() => ReactiveTextField<String>(
        formControlName: field.name,
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          helperText: field.helperText,
          labelText: field.label,
        ),
      );

  Widget _buildIntField() => ReactiveTextField<int>(
        formControlName: field.name,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        decoration: InputDecoration(
          helperText: field.helperText,
          labelText: field.label,
        ),
      );

  Widget _buildDoubleField() => ReactiveTextField<double>(
        formControlName: field.name,
        keyboardType: TextInputType.number,
        inputFormatters: [
          BetweenZeroAndOneFormatter(),
        ],
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        decoration: InputDecoration(
          helperText: field.helperText,
          labelText: field.label,
        ),
      );
}

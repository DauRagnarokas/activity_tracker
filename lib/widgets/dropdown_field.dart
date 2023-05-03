import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';

import '../models/field_props.dart';
import '../providers/bored_api_providers.dart';

class DropDownField extends ConsumerWidget {
  final FieldProps field;

  const DropDownField({super.key, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReactiveDropdownSearch<String, String>(
      formControlName: field.name,
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: const TextStyle(fontSize: 16),
        dropdownSearchDecoration: InputDecoration(
          labelText: field.label,
        ),
      ),
      popupProps: const PopupPropsMultiSelection.menu(
        showSelectedItems: true,
      ),
      items: ref.read(activityTypesProvider),
      showClearButton: true,
    );
  }
}

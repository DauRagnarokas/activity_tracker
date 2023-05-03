import 'package:activity_tracker/models/field_props.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_range_slider/reactive_range_slider.dart';

import '../styles/app_theme.dart';

class RangeSliderField extends HookConsumerWidget {
  final FieldProps field;

  const RangeSliderField({super.key, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<RangeValues> currentRangeValues =
        useState(const RangeValues(0, 1));
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppTheme.inputFillColor,
              borderRadius: const BorderRadius.all(Radius.circular(4))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Row(
                  children: [
                    Expanded(child: Text(field.label)),
                    Text(
                        '${currentRangeValues.value.start.toStringAsFixed(2)} - ${currentRangeValues.value.end.toStringAsFixed(2)}'),
                  ],
                ),
              ),
              ReactiveRangeSlider<RangeValues>(
                formControlName: field.name,
                min: 0,
                max: 1,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                onChangeEnd: (value) {
                  currentRangeValues.value = value;
                },
              ),
            ],
          ),
        ),
        if (field.helperText != null)
          Container(
            alignment: FractionalOffset.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              field.helperText!,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          )
      ],
    );
  }
}

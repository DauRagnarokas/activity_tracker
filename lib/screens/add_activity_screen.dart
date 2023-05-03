import 'package:activity_tracker/models/activity_request.dart';
import 'package:activity_tracker/providers/request_activity_states.dart';
import 'package:activity_tracker/templates/main.dart';
import 'package:activity_tracker/misc/cover_loader.dart';
import 'package:activity_tracker/misc/toast.dart';
import 'package:activity_tracker/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../models/field_props.dart';
import '../providers/request_activity_provider.dart';
import '../routes.dart';
import '../styles/full_width_button.dart';
import '../widgets/error_handler.dart';

class AddActivityScreen extends HookConsumerWidget {
  const AddActivityScreen({super.key});

  _navigate(BuildContext context) => context.go(Routes.home);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<RequestActivityState>(
      requestActivityProvider,
      (_, state) => state.when(
        initial: CoverLoader.remove,
        error: (error, _) {
          Toast.error(
            getErrorMessage(error),
          );
          _navigate(context);
          return null;
        },
        loading: CoverLoader.show,
        data: (_) {
          Toast.success('New activity was added!');
          _navigate(context);
          return null;
        },
      ),
    );
    final List<FieldProps> fields = useMemoized(() => _buildFields());
    final FormGroup form = useMemoized(
      () => fb.group(
        {for (final e in fields) e.name: e.formControl},
      ),
    );
    useEffect(() {
      return () => form.dispose();
    }, []);
    return MainTemplate(
      title: 'Add Activity',
      child: ReactiveFormBuilder(
        form: () => form,
        builder: (context, form, child) => ReactiveFormConsumer(
          builder: (context, formGroup, child) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List<Widget>.generate(
                      fields.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: InputField(field: fields[index]),
                      ),
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    width: double.infinity,
                    child: ReactiveFormConsumer(
                      builder: (BuildContext context, form, child) {
                        return const _SubmitButton();
                      },
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  List<FieldProps> _buildFields() => [
        FieldProps(
          name: 'type',
          label: 'Type',
          type: FieldType.dropdown,
          formControl: FormControl<String>(),
        ),
        FieldProps(
          name: 'accessibility',
          label: 'Accessibility',
          helperText:
              'A factor describing how possible an event is to do with zero being the most accessible [0.0, 1.0]',
          type: FieldType.slider,
          formControl: FormControl<RangeValues>(
            value: const RangeValues(0, 1),
          ),
        ),
        FieldProps(
          name: 'participants',
          label: 'Participants',
          helperText: 'The number of people that this activity could involve',
          type: FieldType.int,
          formControl: FormControl<int>(value: null, validators: [
            Validators.pattern(RegExp(r'^$|\d+$')),
          ]),
        ),
        FieldProps(
          name: 'price',
          label: 'Price',
          helperText:
              'A factor describing the cost of the event with zero being free [0, 1]',
          type: FieldType.slider,
          formControl: FormControl<RangeValues>(
            value: const RangeValues(0, 1),
          ),
        ),
      ];
}

class _SubmitButton extends HookConsumerWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ReactiveForm.of(context);
    return ElevatedButton(
      style: fullWidthButton,
      onPressed: form == null || !form.valid
          ? null
          : () => ref.read(requestActivityProvider.notifier).add(
                activityRequest: ActivityUploadData.fromJson(
                    form.value as Map<String, dynamic>),
              ),
      child: const Text('Submit'),
    );
  }
}

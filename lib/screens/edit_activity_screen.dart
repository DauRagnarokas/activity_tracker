import 'package:activity_tracker/models/activity.dart';
import 'package:activity_tracker/providers/activities_provider.dart';
import 'package:activity_tracker/providers/request_activity_states.dart';
import 'package:activity_tracker/styles/full_width_button.dart';
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
import '../widgets/error_handler.dart';

class EditActivityScreen extends HookConsumerWidget {
  final String id;

  const EditActivityScreen({super.key, required this.id});

  _navigate(BuildContext context) => context.go(Routes.home);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Activity activity = ref.watch(activitiesProvider).firstWhere(
          (element) => element.key == id,
        );
    ref.listen<RequestActivityState>(
      requestActivityProvider,
      (_, state) => state.when(
        initial: () => CoverLoader.remove(),
        error: (error, _) {
          Toast.error(
            getErrorMessage(error),
          );
          _navigate(context);
          return null;
        },
        loading: () => CoverLoader.show(),
        data: (_) {
          Toast.success('New activity was added!');
          _navigate(context);
          return null;
        },
      ),
    );
    final List<FieldProps> fields = useMemoized(() => _buildFields(activity));
    final FormGroup form = useMemoized(
      () => fb.group(
        {for (final e in fields) e.name: e.formControl},
      ),
    );
    useEffect(() {
      return () => form.dispose();
    }, []);
    return MainTemplate(
      title: 'Edit Activity',
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
                        child: InputField(
                          field: fields[index],
                          isLast: index == fields.length - 1,
                        ),
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
                        return _SubmitButton(
                            activity: activity, fields: fields);
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

  List<FieldProps> _buildFields(Activity activity) => [
        FieldProps(
          name: 'activity',
          label: 'Activity',
          type: FieldType.text,
          formControl: FormControl<String>(
              value: activity.activity, validators: [Validators.required]),
        ),
        FieldProps(
          name: 'type',
          label: 'Type',
          type: FieldType.dropdown,
          formControl: FormControl<String>(
              value: activity.type, validators: [Validators.required]),
        ),
        FieldProps(
          name: 'accessibility',
          label: 'Accessibility',
          helperText:
              'A factor describing how possible an event is to do with zero being the most accessible [0.0, 1.0]',
          type: FieldType.double,
          formControl:
              FormControl<double>(value: activity.accessibility, validators: [
            Validators.required,
            Validators.min(0),
            Validators.max(1),
          ]),
        ),
        FieldProps(
          name: 'participants',
          label: 'Participants',
          helperText: 'The number of people that this activity could involve',
          type: FieldType.int,
          formControl:
              FormControl<int>(value: activity.participants, validators: [
            Validators.required,
            Validators.min(0),
          ]),
        ),
        FieldProps(
          name: 'price',
          label: 'Price',
          helperText:
              'A factor describing the cost of the event with zero being free [0, 1]',
          type: FieldType.double,
          formControl: FormControl<double>(value: activity.price, validators: [
            Validators.required,
            Validators.min(0),
            Validators.max(1),
          ]),
        ),
      ];
}

class _SubmitButton extends HookConsumerWidget {
  final Activity activity;
  final List<FieldProps> fields;

  const _SubmitButton({required this.activity, required this.fields});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ReactiveForm.of(context);
    return ElevatedButton(
      style: fullWidthButton,
      onPressed: form == null || !form.valid
          ? null
          : () {
              final Activity freshActivity = activity.copyWith(
                activity: fields
                    .firstWhere((element) => element.name == 'activity')
                    .formControl
                    .value,
                accessibility: fields
                    .firstWhere((element) => element.name == 'accessibility')
                    .formControl
                    .value,
                participants: fields
                    .firstWhere((element) => element.name == 'participants')
                    .formControl
                    .value,
                type: fields
                    .firstWhere((element) => element.name == 'type')
                    .formControl
                    .value,
                price: fields
                    .firstWhere((element) => element.name == 'price')
                    .formControl
                    .value,
              );
              ref.read(activitiesProvider.notifier).update(freshActivity);
              context.pop();
              Toast.success('Activity was updated.');
            },
      child: const Text('Submit'),
    );
  }
}

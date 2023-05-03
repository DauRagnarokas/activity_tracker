import 'package:activity_tracker/models/activity.dart';
import 'package:activity_tracker/providers/activities_provider.dart';
import 'package:activity_tracker/providers/request_activity_states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/activity_request.dart';
import 'bored_api_providers.dart';

part 'request_activity_provider.g.dart';

@riverpod
class RequestActivity extends _$RequestActivity {
  @override
  RequestActivityState build() => const RequestActivityState.initial();

  add({
    required ActivityUploadData activityRequest,
    Function(Activity)? callback,
  }) async {
    try {
      state = const RequestActivityState.loading();
      final Activity newActivity = await ref.read(getActivityProvider(
        queryParameters: activityRequest.toJson(),
      ).future);
      ref.read(activitiesProvider.notifier).add(newActivity);
      state = RequestActivityState.data(newActivity);
      callback?.call(newActivity);
    } catch (error, stack) {
      state = RequestActivityState.error(error, stack);
    } finally {
      state = const RequestActivityState.initial();
    }
  }
}

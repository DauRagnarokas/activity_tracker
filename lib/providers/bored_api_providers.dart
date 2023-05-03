import 'package:activity_tracker/models/activity.dart';

import '../services/dio_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bored_api_providers.g.dart';

const baseUrl = 'http://www.boredapi.com/api/activity';

@riverpod
List<String> activityTypes(_) => [
      'education',
      'recreational',
      'social',
      'diy',
      'charity',
      'cooking',
      'relaxation',
      'music',
      'busywork',
    ];

@riverpod
Future<Activity> getActivity(GetActivityRef ref, {required Map<String, dynamic> queryParameters}) async =>
    await ref.read(dioServiceProvider).getData(
          path: baseUrl,
          queryParameters: queryParameters,
          builder: (dynamic data) => Activity.fromJson(data),
        );

import 'package:activity_tracker/models/activity.dart';
import 'package:activity_tracker/exceptions/exception_with_toast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activities_provider.g.dart';

@riverpod
class Activities extends _$Activities {
  @override
  Set<Activity> build() => {};

  add(Activity activity) {
    if (state.map((e) => e.key).toSet().contains(activity.key)) {
      throw ExceptionWithToast('Activity already exists');
    }
    state = {activity, ...state};
  }

  update(Activity activity) {
    remove(activity);
    add(activity);
  }

  remove(Activity activity) {
    state = state.where((element) => element.key != activity.key).toSet();
  }
}

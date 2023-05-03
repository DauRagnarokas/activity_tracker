import 'package:freezed_annotation/freezed_annotation.dart';
part 'request_activity_states.freezed.dart';

@freezed
abstract class RequestActivityState<T> with _$RequestActivityState<T> {
  const factory RequestActivityState.initial() = _Initial;
  const factory RequestActivityState.data(T data) = _Data;
  const factory RequestActivityState.error(Object error, StackTrace stack) = _Error;
  const factory RequestActivityState.loading() = _Loading;
}

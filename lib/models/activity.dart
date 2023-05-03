import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity.freezed.dart';

part 'activity.g.dart';

@Freezed()
class Activity with _$Activity {
  const Activity._();

  const factory Activity({
    required String activity,
    required double accessibility,
    required String type,
    required int participants,
    required double price,
    String? link,
    required String key,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
}

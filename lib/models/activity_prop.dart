import 'package:activity_tracker/extensions/string_extensions.dart';
import 'package:flutter/foundation.dart';

@immutable
class ActivityProp {
  final String name;
  final String value;

  const ActivityProp({
    required this.name,
    required this.value,
  });

  String get nameCapitalized => name.capitalize();
}

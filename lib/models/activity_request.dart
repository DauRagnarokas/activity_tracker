import 'package:activity_tracker/extensions/double_extensions.dart';
import 'package:flutter/material.dart';

class ActivityUploadData {
  final String? type;
  final int? participants;
  final double minprice;
  final double maxprice;
  final double minaccessibility;
  final double maxaccessibility;

  ActivityUploadData({
    this.type,
    this.participants,
    this.minprice = 0,
    this.maxprice = 1,
    this.minaccessibility = 0,
    this.maxaccessibility = 1,
  });

  ActivityUploadData.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        participants = json['participants'],
        minprice = (json['price'] as RangeValues).start.toPrecision(2),
        maxprice = (json['price'] as RangeValues).end.toPrecision(2),
        minaccessibility =
            (json['accessibility'] as RangeValues).start.toPrecision(2),
        maxaccessibility =
            (json['accessibility'] as RangeValues).end.toPrecision(2);

  Map<String, dynamic> toJson() => {
        'type': type,
        'participants': participants,
        'minprice': minprice,
        'maxprice': maxprice,
        'minaccessibility': minaccessibility,
        'maxaccessibility': maxaccessibility,
      };

  @override
  String toString() => toJson().toString();
}

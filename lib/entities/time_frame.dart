import 'package:flutter/foundation.dart';

enum DayOfWeek {
  SUNDAY,
  MONDAY,
  TUESDAY,
  WEDNESDAY,
  THURSDAY,
  FRIDAY,
  SATURDAY
}

class TimeFrame {
  final int from;
  final int to;
  final DayOfWeek dof;

  TimeFrame({
    @required this.from,
    @required this.to,
    @required this.dof,
  });

  TimeFrame.fromJson(Map<String, dynamic> json)
      : from = json["from"],
        to = json["to"],
        dof = DayOfWeek.values.firstWhere(
            (val) => val.toString().substring(10) == json["day_of_week"]);
}

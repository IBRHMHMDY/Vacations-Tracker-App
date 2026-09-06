import 'package:flutter/material.dart';

/// امتداد المظهر المخصص لألوان حالات الإجازات
class LeaveColors extends ThemeExtension<LeaveColors> {
  final Color regular;
  final Color casual;
  final Color sick;
  final Color rest;
  final Color usedRest;

  const LeaveColors({
    required this.regular,
    required this.casual,
    required this.sick,
    required this.rest,
    required this.usedRest
  });

  @override
  ThemeExtension<LeaveColors> copyWith({
    Color? regular,
    Color? casual,
    Color? sick,
    Color? rest,
    Color? usedRest
  }) {
    return LeaveColors(
      regular: regular ?? this.regular,
      casual: casual ?? this.casual,
      sick: sick ?? this.sick,
      rest: rest ?? this.rest,
      usedRest: usedRest ?? this.usedRest,
    );
  }

  @override
  ThemeExtension<LeaveColors> lerp(
    covariant ThemeExtension<LeaveColors>? other,
    double t,
  ) {
    if (other is! LeaveColors) return this;
    return LeaveColors(
      regular: Color.lerp(regular, other.regular, t)!,
      casual: Color.lerp(casual, other.casual, t)!,
      sick: Color.lerp(sick, other.sick, t)!,
      rest: Color.lerp(rest, other.rest, t)!,
      usedRest: Color.lerp(usedRest, other.usedRest, t)!,
    );
  }
}

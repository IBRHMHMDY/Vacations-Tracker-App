import 'package:equatable/equatable.dart';

class LeaveBalance extends Equatable {
  final int remainingRegular;
  final int remainingCasual;
  final int remainingSick;
  const LeaveBalance({
    required this.remainingRegular,
    required this.remainingCasual,
    required this.remainingSick
  });

  @override
  List<Object?> get props => [remainingRegular, remainingCasual, remainingSick];
}
import '../../domain/entities/leave_record_entity.dart';
import '../../../../core/utils/enums/leave_type.dart';
import '../../../../core/database/app_database.dart';



extension LeaveRecordMapper on LeaveRecordModel {
  LeaveRecord toDomain() {
    return LeaveRecord(
      id: id,
      leaveType: _mapLeaveType(leaveType),
      startDate: startDate,
      endDate: endDate,
      daysCount: daysCount,
      notes: notes,
    );
  }

  LeaveType _mapLeaveType(int type) {
    if (type == 0) return LeaveType.regular;
    if (type == 1) return LeaveType.casual;
    return LeaveType.sick; // ✅ النوع الجديد
  }
}
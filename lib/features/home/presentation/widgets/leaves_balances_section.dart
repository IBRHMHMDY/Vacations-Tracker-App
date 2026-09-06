// lib/features/home/presentation/widgets/leaves_balances_section.dart
import 'package:flutter/material.dart';
import 'package:leave_manager/core/constants/app_spacing.dart';
import 'package:leave_manager/core/utils/extenstions/theme_extension.dart';
import 'package:leave_manager/features/leaves/domain/entities/leave_balance_entity.dart';
import 'package:leave_manager/features/settings/domain/entities/settings_entity.dart';
import 'balance_circular_indicator.dart';

class LeavesBalancesSection extends StatelessWidget {
  final LeaveBalance balance;
  final Settings settings;

  const LeavesBalancesSection({
    super.key,
    required this.balance,
    required this.settings,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BalanceCircularIndicator(
            title: 'اعتيادي',
            remaining: balance.remainingRegular,
            total: settings.totalRegularLeaves,
            color: context.leaveColors.regular,
          ),
        ),
        const SizedBox(width: AppSpacing.sm), // تقليل المسافة لتناسب 3 دوائر
        Expanded(
          child: BalanceCircularIndicator(
            title: 'عارضة',
            remaining: balance.remainingCasual,
            total: settings.totalCasualLeaves,
            color: context.leaveColors.casual,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: BalanceCircularIndicator(
            title: 'مرضي',
            remaining: balance.remainingSick, // ✅ تمرير رصيد المرضي المتبقي
            total: settings.totalSickLeaves,  // ✅ تمرير إجمالي المرضي
            color: context.leaveColors.sick,  // ✅ تمرير لون المرضي
          ),
        ),
      ],
    );
  }
}
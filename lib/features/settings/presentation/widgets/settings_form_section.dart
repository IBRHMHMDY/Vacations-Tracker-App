// lib/features/settings/presentation/widgets/settings_form_section.dart
import 'package:flutter/material.dart';
import 'package:leave_manager/core/constants/app_spacing.dart';
import 'package:leave_manager/core/utils/extenstions/theme_extension.dart';
import 'package:leave_manager/shared/widgets/inputs/app_counter_row.dart';
import 'package:leave_manager/shared/widgets/widgets.dart';

class SettingsFormSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController jobController;
  final TextEditingController regularLeavesController;
  final TextEditingController casualLeavesController;
  final TextEditingController sickLeavesController;

  const SettingsFormSection({
    super.key,
    required this.nameController,
    required this.jobController,
    required this.regularLeavesController,
    required this.casualLeavesController,
    required this.sickLeavesController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('البيانات الشخصية', style: context.textTheme.titleLarge),
        const SizedBox(height: AppSpacing.md),

        AppTextField(
          label: 'اسم الموظف',
          icon: Icons.person_outline,
          controller: nameController,
          validator: (val) =>
              val == null || val.trim().isEmpty ? 'مطلوب' : null,
        ),

        AppTextField(
          label: 'المسمى الوظيفي',
          icon: Icons.work_outline,
          controller: jobController,
          validator: (val) =>
              val == null || val.trim().isEmpty ? 'مطلوب' : null,
        ),

        const SizedBox(height: AppSpacing.sm),
        Text('الأرصدة السنويه المستحقة', style: context.textTheme.titleLarge),
        const SizedBox(height: AppSpacing.md),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: regularLeavesController,
              builder: (context, value, child) {
                final currentValue = int.tryParse(value.text) ?? 15;
                return AppCounterRow(
                  label: 'إجمالي الاعتيادي',
                  value: currentValue,
                  min: 15,
                  max: 45,
                  onChanged: (newValue) {
                    regularLeavesController.text = newValue.toString();
                  },
                );
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: casualLeavesController,
              builder: (context, value, child) {
                final currentValue = int.tryParse(value.text) ?? 7;
                return AppCounterRow(
                  label: 'إجمالي العارضة',
                  value: currentValue,
                  min: 6,
                  max: 7,
                  onChanged: (newValue) {
                    casualLeavesController.text = newValue.toString();
                  },
                );
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            // ✅ قسم الإجازة المرضية الجديد
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: sickLeavesController,
              builder: (context, value, child) {
                final currentValue = int.tryParse(value.text) ?? 0;
                return AppCounterRow(
                  label: 'اجمالى المرضى',
                  value: currentValue,
                  min: 0,
                  max: 90, // الحد الأقصى التقريبي
                  onChanged: (newValue) => sickLeavesController.text = newValue.toString(),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacation_tracker/core/constants/app_colors.dart';
// import 'package:vacation_tracker/core/utils/share_util.dart';
import 'package:vacation_tracker/presentation/blocs/leaves/leaves_bloc.dart';
import 'package:vacation_tracker/presentation/blocs/settings/settings_bloc.dart';
import 'package:vacation_tracker/presentation/widgets/add_leave_form.dart';
import 'package:vacation_tracker/presentation/widgets/build_balances_section.dart';
import 'package:vacation_tracker/presentation/widgets/build_current_month_leaves.dart';
import 'package:vacation_tracker/presentation/widgets/build_financialyear_card.dart';
import 'package:vacation_tracker/presentation/widgets/build_greeting_card.dart';
import 'package:vacation_tracker/presentation/widgets/build_smart_alerts.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LeavesBloc, LeavesState>(
      listener: (context, state) {
        // إظهار رسالة الخطأ إذا تم رفض تسجيل الإجازة
        if (state is LeavesError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red.shade700,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        // إظهار رسالة نجاح عند إتمام الحفظ
        else if (state is LeaveAddedSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم تسجيل الإجازة بنجاح'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },

      child: Scaffold(
        appBar: AppBar(
          title: const Text('لوحة المعلومات'),
          centerTitle: false,
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.share_outlined),
          //     tooltip: 'مشاركة التطبيق',
          //     onPressed: () async {
          //       await ShareUtil.shareApplication();
          //     },
          //   ),
          // ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<SettingsBloc>().add(LoadSettingsEvent());
            context.read<LeavesBloc>().add(LoadBalancesAndLeavesEvent());
          },
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              BuildGreetingCard(key: key),
              const SizedBox(height: 16),
              BuildFinancialYearCard(context),
              const SizedBox(height: 16),
              BuildSmartAlerts(key: key,),
              const SizedBox(height: 16),
              BuildBalancesSection(context),
              const SizedBox(height: 24),
              BuildCurrentMonthLeaves(context),
              const SizedBox(height: 80),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddLeaveBottomSheet(context),
          icon: const Icon(Icons.add),
          label: const Text('إجازة جديدة'),
          backgroundColor: AppColors.accentCoral,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

 
  

  void _showAddLeaveBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: AddLeaveForm(parentContext: context),
      ),
    );
  }
}



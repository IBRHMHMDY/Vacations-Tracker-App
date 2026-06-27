import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacation_tracker/presentation/blocs/leaves/leaves_bloc.dart';
import 'package:vacation_tracker/presentation/widgets/custom_alert_banner.dart';

class BuildSmartAlerts extends StatelessWidget {
  const BuildSmartAlerts({super.key}); // تم تصحيح الـ Constructor

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeavesBloc, LeavesState>(
      builder: (context, state) {
        if (state is LeavesLoaded) {
          List<Widget> alerts = [];
          final currentMonth = DateTime.now().month;

          // إضافة تنبيه معلوماتي (Info)
          if (currentMonth == 6) {
            alerts.add(
              const CustomAlertBanner( 
                message: 'تنبيه: اقترب موعد نهاية السنة المالية، يرجى تسوية رصيد إجازاتك.',
                type: AlertType.info,
              ),
            );
          }

          // إضافة تحذير / خطأ (Error)
          if (state.balance.remainingRegular <= 3) {
            alerts.add(
              const CustomAlertBanner(
                message: 'تحذير: متبقى من رصيد اجازاتك الاعتياديه 3 ايام فقط.',
                type: AlertType.error,
              ),
            );
          }
          if (state.balance.remainingCasual <= 3) {
            alerts.add(
              const CustomAlertBanner(
                message: 'تحذير: متبقى من رصيد اجازاتك العارضه 3 ايام فقط.',
                type: AlertType.error,
              ),
            );
          }
          return Column(children: alerts);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
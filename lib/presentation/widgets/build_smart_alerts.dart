import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacation_tracker/presentation/blocs/leaves/leaves_bloc.dart';

class BuildSmartAlerts extends StatelessWidget {
  const BuildSmartAlerts(BuildContext context,{super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeavesBloc, LeavesState>(
      builder: (context, state) {
        if (state is LeavesLoaded) {
          List<Widget> alerts = [];
          final currentMonth = DateTime.now().month;

          if (currentMonth == 6) {
            alerts.add(
              _alertBanner(
                context,
                'اقترب موعد انتهاء السنة المالية، يرجى مراجعة أرصدتك.',
              ),
            );
          }

          if (state.balance.remainingRegular <= 3) {
            alerts.add(
              _alertBanner(
                context,
                'تنبيه: رصيد إجازاتك الاعتيادية قارب على النفاذ!',
                isWarning: true,
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

Widget _alertBanner(
    BuildContext context,
    String message, {
    bool isWarning = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isWarning
            ? Colors.red.withAlpha(1)
            : Colors.orange.withAlpha(1),
        border: Border.all(color: isWarning ? Colors.red : Colors.orange),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: isWarning ? Colors.red : Colors.orange,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: isWarning ? Colors.red : Colors.orange),
            ),
          ),
        ],
      ),
    );
  }

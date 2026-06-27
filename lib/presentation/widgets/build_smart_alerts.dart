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
                'تنبيه: اقترب موعد نهاية السنة المالية، يرجى تسوية رصيد إجازاتك.',
              ),
            );
          }

          if (state.balance.remainingRegular <= 3) {
            alerts.add(
              _alertBanner(
                context,
                'تحذير: رصيد إجازاتك الاعتيادية منخفض جداً.',
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

  Widget _alertBanner(
    BuildContext context,
    String message, {
    bool isWarning = false,
  }) {
    // FIX: Changed withAlpha(1) to withAlpha(25) for proper visibility.
    final Color baseColor = isWarning ? Colors.red : Colors.orange;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: baseColor.withAlpha(25), 
        border: Border.all(color: baseColor, width: 1.5), // Added slight width for better UI
        borderRadius: BorderRadius.circular(12), // Smoother borders
      ),
      child: Row(
        children: [
          Icon(
            isWarning ? Icons.warning_amber_rounded : Icons.info_outline, // Improved semantics
            color: baseColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: isWarning ? Colors.red.shade900 : Colors.orange.shade900, // Better text readability
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
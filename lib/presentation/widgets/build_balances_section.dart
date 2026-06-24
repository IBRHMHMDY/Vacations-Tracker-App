import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacation_tracker/core/constants/app_colors.dart';
import 'package:vacation_tracker/presentation/blocs/leaves/leaves_bloc.dart';
import 'package:vacation_tracker/presentation/blocs/settings/settings_bloc.dart';

class BuildBalancesSection extends StatelessWidget {
  const BuildBalancesSection(BuildContext context,{super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingsState) {
        return BlocBuilder<LeavesBloc, LeavesState>(
          builder: (context, leavesState) {
            if (settingsState is SettingsLoaded &&
                leavesState is LeavesLoaded) {
              return Row(
                children: [
                  Expanded(
                    child: _buildCircularIndicator(
                      context,
                      'اعتيادي',
                      leavesState.balance.remainingRegular,
                      settingsState.settings.totalRegularLeaves,
                      AppColors.regularLeaveColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildCircularIndicator(
                      context,
                      'عارضه',
                      leavesState.balance.remainingCasual,
                      settingsState.settings.totalCasualLeaves,
                      AppColors.casualLeaveColor,
                    ),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}

Widget _buildCircularIndicator(
    BuildContext context,
    String title,
    int remaining,
    int total,
    Color color,
  ) {
    double progress = total > 0 ? (remaining / total) : 0;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                    backgroundColor: color.withAlpha(2),
                    color: color,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '$remaining',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      'من $total',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
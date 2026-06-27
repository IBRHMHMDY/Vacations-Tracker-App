import 'package:flutter/material.dart';

// نقلنا الـ Enum إلى هنا ليكون متاحاً عالمياً مع المكون
enum AlertType { info, warning, error }

class CustomAlertBanner extends StatelessWidget {
  final String message;
  final AlertType type;

  const CustomAlertBanner({
    super.key,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Color baseColor;
    IconData iconData;
    Color bgColor;
    Color textColor;

    // تحديد خصائص كل نوع بناءً على المتغير الممرر
    switch (type) {
      case AlertType.info:
        baseColor = Colors.blue.shade600;
        iconData = Icons.info_outline_rounded;
        bgColor = Colors.blue.shade50;
        textColor = Colors.blue.shade900;
        break;
      case AlertType.warning:
        baseColor = Colors.orange.shade600;
        iconData = Icons.warning_amber_rounded;
        bgColor = Colors.orange.shade50;
        textColor = Colors.orange.shade900;
        break;
      case AlertType.error:
        baseColor = Colors.red.shade600;
        iconData = Icons.error_outline_rounded;
        bgColor = Colors.red.shade50;
        textColor = Colors.red.shade900;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: baseColor.withAlpha(40), width: 1),
        boxShadow: [
          BoxShadow(
            color: baseColor.withAlpha(15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: baseColor.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: baseColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                message,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
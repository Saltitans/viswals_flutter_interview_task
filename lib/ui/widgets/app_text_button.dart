import 'package:flutter/material.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/montserrat_text_styles.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    this.enabled = true,
    required this.label,
    required this.onTap,
  });

  final bool enabled;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Text(
        label,
        style: MontserratTextStyles.label13Regular.copyWith(
          color: enabled ? AppColors.grey : AppColors.greyOpacity30,
        ),
      ),
    );
  }
}

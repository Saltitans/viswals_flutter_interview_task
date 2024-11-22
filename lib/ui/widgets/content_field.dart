import 'package:flutter/material.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/roboto_text_styles.dart';

class ContentField extends StatelessWidget {
  const ContentField({
    super.key,
    required this.label,
    this.content,
    this.trailingIcon,
    required this.onTap,
  });

  final String label;
  final String? content;
  final IconData? trailingIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 48,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.blueOpacity05,
            border: Border.all(color: AppColors.blueOpacity50),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (content == null)
                        Text(
                          label,
                          style: RobotoTextStyles.label13Regular.copyWith(
                            color: AppColors.grey,
                          ),
                        )
                      else ...[
                        Text(
                          label,
                          style: RobotoTextStyles.label9Regular.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        Text(
                          content!,
                          style: RobotoTextStyles.label13Regular.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailingIcon != null) ...[
                  const SizedBox(width: 16),
                  Icon(
                    size: 16,
                    trailingIcon,
                    color: AppColors.grey,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/montserrat_text_styles.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/primary_button.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/secondary_button.dart';
import 'package:viswals_flutter_interview_task/utils/enums.dart';

class DocumentTypeBottomSheet extends StatelessWidget {
  const DocumentTypeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final (index, type) in DocumentType.values.indexed) ...[
            SecondaryButton(
              label: type.label,
              onTap: () => Navigator.of(context).maybePop(type),
            ),
            if (index < DocumentType.values.length - 1)
              const SizedBox(height: 16),
          ],
          const SizedBox(height: 16),
          PrimaryButton(
            backgroundColor: AppColors.black2,
            label: Text(
              'CANCEL',
              style: MontserratTextStyles.label13ExtraBold
                  .copyWith(color: AppColors.grey),
            ),
            onTap: Navigator.of(context).maybePop,
          ),
          const SizedBox(height: 42),
        ],
      ),
    );
  }
}

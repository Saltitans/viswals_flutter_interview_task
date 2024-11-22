import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viswals_flutter_interview_task/state/user_profile_provider.dart';
import 'package:viswals_flutter_interview_task/ui/screens/user_profile_quizz/sections/document_type/components/document_type_bottom_sheet.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/montserrat_text_styles.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/content_field.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/primary_button.dart';
import 'package:viswals_flutter_interview_task/utils/enums.dart';
import 'package:viswals_flutter_interview_task/utils/functions.dart';

class UserProfileQuizzDocumentTypeSection extends StatelessWidget {
  const UserProfileQuizzDocumentTypeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ContentField(
              label: 'Type',
              content: provider.documentType?.label,
              trailingIcon: Icons.arrow_drop_down,
              onTap: () async {
                final result = await showAppModalBottomSheet<DocumentType>(
                  context: context,
                  child: const DocumentTypeBottomSheet(),
                );
                if (result == null) return;
                provider.setDocumentType(result);
              },
            ),
            const Spacer(),
            PrimaryButton(
              backgroundColor: provider.documentType != null
                  ? AppColors.blue
                  : AppColors.blueOpacity15,
              label: Text(
                'NEXT',
                style: MontserratTextStyles.label13Bold.copyWith(
                  color: provider.documentType != null
                      ? AppColors.white
                      : AppColors.whiteOpacity15,
                ),
              ),
              onTap: provider.documentType != null
                  ? provider.jumpToNextSection
                  : null,
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viswals_flutter_interview_task/state/user_profile_provider.dart';
import 'package:viswals_flutter_interview_task/ui/screens/user_profile_quizz/sections/document_number_country/user_profile_quizz_document_number_country_section.dart';
import 'package:viswals_flutter_interview_task/ui/screens/user_profile_quizz/sections/document_type/user_profile_quizz_document_type_section.dart';
import 'package:viswals_flutter_interview_task/ui/screens/user_profile_quizz/sections/photos/photos_section.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/montserrat_text_styles.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_circular_progress_indicator.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_screen.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_text_button.dart';
import 'package:viswals_flutter_interview_task/utils/enums.dart';

class UserProfileQuizzScreen extends StatelessWidget {
  const UserProfileQuizzScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, provider, _) {
        return AppScreen(
          backButton: AppBackButton(
            onTap: () {
              Navigator.of(context).maybePop();
              provider.resetSection();
            },
          ),
          title: 'Information',
          actions: [
            if (provider.currentQuizzSection != UserProfileQuizzSection.photos)
              AppTextButton(
                enabled: provider.canSkip(),
                label: 'Skip',
                onTap: provider.skipSection,
              ),
          ],
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 18.5),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Document Details',
                        style: MontserratTextStyles.label24Black.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    AppCircularProgressIndicator(
                      dimension: 184,
                      totalSteps: UserProfileQuizzSection.values.length,
                      selectedStep: UserProfileQuizzSection.values
                              .indexOf(provider.currentQuizzSection) +
                          1,
                      stepCompletenessChecker:
                          provider.quizzStepCompletenessChecker,
                      completenessPercentage:
                          provider.quizzCompletenessPercentage(),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                Expanded(
                  child: switch (provider.currentQuizzSection) {
                    UserProfileQuizzSection.documentType =>
                      const UserProfileQuizzDocumentTypeSection(),
                    UserProfileQuizzSection.documentNumberAndCountry =>
                      const UserProfileQuizzDocumentNumberCountrySection(),
                    UserProfileQuizzSection.photos => const PhotosSection(),
                  },
                ),
                const SizedBox(height: 42),
              ],
            ),
          ),
        );
      },
    );
  }
}

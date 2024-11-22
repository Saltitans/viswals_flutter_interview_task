import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viswals_flutter_interview_task/state/user_profile_provider.dart';
import 'package:viswals_flutter_interview_task/ui/screens/user_profile_quizz/user_profile_quizz_screen.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/montserrat_text_styles.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/roboto_text_styles.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_circular_progress_indicator.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_screen.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/primary_button.dart';
import 'package:viswals_flutter_interview_task/utils/enums.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, provider, _) {
        final completenessPercentage = provider.quizzCompletenessPercentage();

        return AppScreen(
          title: 'User Profile',
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Spacer(),
                Column(
                  children: [
                    AppCircularProgressIndicator(
                      dimension: 184,
                      totalSteps: UserProfileQuizzSection.values.length,
                      selectedStep: 0,
                      stepCompletenessChecker:
                          provider.quizzStepCompletenessChecker,
                      completenessPercentage: completenessPercentage,
                    ),
                    const SizedBox(height: 69),
                    Text(
                      'Document Details',
                      style: MontserratTextStyles.label24Black
                          .copyWith(color: AppColors.white),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "Let's create a user profile",
                      style: RobotoTextStyles.label13Regular
                          .copyWith(color: AppColors.blue),
                    ),
                  ],
                ),
                const Spacer(),
                PrimaryButton(
                  backgroundColor: AppColors.lightGrey,
                  label: Text(
                    completenessPercentage == 0 ? 'START' : 'CONTINUE',
                    style: MontserratTextStyles.label13Bold,
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const UserProfileQuizzScreen(),
                    ),
                  ),
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

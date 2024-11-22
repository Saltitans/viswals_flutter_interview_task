import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viswals_flutter_interview_task/state/user_profile_provider.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/montserrat_text_styles.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/roboto_text_styles.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_circular_progress_indicator.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_screen.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/primary_button.dart';
import 'package:viswals_flutter_interview_task/utils/enums.dart';

class UserProfileQuizzEndScreen extends StatelessWidget {
  const UserProfileQuizzEndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = context.read<UserProfileProvider>();

    return AppScreen(
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
                  stepCompletenessChecker:
                      userProfileProvider.quizzStepCompletenessChecker,
                  completenessPercentage:
                      userProfileProvider.quizzCompletenessPercentage(),
                  progressIndicatorForegroundColor: AppColors.darkGrey5,
                  percentageColor: AppColors.blue,
                ),
                const SizedBox(height: 69),
                Text(
                  'Congratulations!',
                  style: MontserratTextStyles.label24Black
                      .copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 21),
                Text(
                  'Quizz 100% Completed',
                  style: RobotoTextStyles.label13Regular
                      .copyWith(color: AppColors.blue),
                ),
              ],
            ),
            const Spacer(),
            PrimaryButton(
              backgroundColor: AppColors.white,
              label: Text(
                'RE-START',
                style: MontserratTextStyles.label13Bold,
              ),
              onTap: () {
                Navigator.of(context).maybePop();
                userProfileProvider.resetState();
              },
            ),
            const SizedBox(height: 42),
          ],
        ),
      ),
    );
  }
}

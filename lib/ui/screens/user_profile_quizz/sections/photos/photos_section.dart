import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viswals_flutter_interview_task/services/file_pick_service.dart';
import 'package:viswals_flutter_interview_task/state/user_profile_provider.dart';
import 'package:viswals_flutter_interview_task/ui/screens/photo_planning/photo_planning_screen.dart';
import 'package:viswals_flutter_interview_task/ui/screens/user_profile_quizz_end/user_profile_quizz_end_screen.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/montserrat_text_styles.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/content_field.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/primary_button.dart';

class PhotosSection extends StatelessWidget {
  const PhotosSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, provider, _) {
        final canFinish = provider.quizzCompletenessPercentage() == 100;

        return Column(
          children: [
            ContentField(
              label: 'Photos',
              content: provider.isProfilePhotoReady && provider.isCardPhotoReady
                  ? 'User_Photos.${provider.getPickedPhotoExtension()}'
                  : null,
              trailingIcon: Icons.camera_alt,
              onTap: () async {
                try {
                  final filePickService = context.read<FilePickService>();
                  final photo = await filePickService.pickPhoto();

                  if (photo == null) return;

                  provider.setPickedPhoto(photo);

                  await Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const PhotoPlanningScreen(),
                    ),
                  );
                } catch (_) {}
              },
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    backgroundColor: AppColors.grey,
                    label: Text(
                      'PREV',
                      style: MontserratTextStyles.label13Bold
                          .copyWith(color: AppColors.grey2),
                    ),
                    onTap: provider.previousSection,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: PrimaryButton(
                    backgroundColor:
                        canFinish ? AppColors.blue : AppColors.blueOpacity15,
                    label: Text(
                      'FINISH',
                      style: MontserratTextStyles.label13Bold.copyWith(
                        color: canFinish
                            ? AppColors.white
                            : AppColors.whiteOpacity15,
                      ),
                    ),
                    onTap: canFinish
                        ? () => Navigator.of(context).pushReplacement(
                              MaterialPageRoute<void>(
                                builder: (context) =>
                                    const UserProfileQuizzEndScreen(),
                              ),
                            )
                        : null,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

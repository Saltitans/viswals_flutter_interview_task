import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:viswals_flutter_interview_task/services/file_pick_service.dart';
import 'package:viswals_flutter_interview_task/state/user_profile_provider.dart';
import 'package:viswals_flutter_interview_task/ui/screens/photo_planning/sections/card/photo_planning_card_section.dart';
import 'package:viswals_flutter_interview_task/ui/screens/photo_planning/sections/profile/photo_planning_profile_section.dart';
import 'package:viswals_flutter_interview_task/ui/screens/preview_photo_planning_card/preview_photo_planning_card_screen.dart';
import 'package:viswals_flutter_interview_task/ui/screens/preview_photo_planning_profile/preview_photo_planning_profile_screen.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/montserrat_text_styles.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_screen.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_tab_bar.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/primary_button.dart';
import 'package:viswals_flutter_interview_task/utils/enums.dart';

class PhotoPlanningScreen extends HookWidget {
  const PhotoPlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);

    return AppScreen(
      title: 'Photo Planning',
      body: Column(
        children: [
          Consumer<UserProfileProvider>(
            builder: (context, provider, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AppTabBar(
                  controller: tabController,
                  tabs: [
                    for (final section in PhotoPlanningSection.values)
                      AppTab(
                        label: section.label,
                        isComplete: switch (section) {
                          PhotoPlanningSection.profile =>
                            provider.isProfilePhotoReady,
                          PhotoPlanningSection.card =>
                            provider.isCardPhotoReady,
                        },
                      ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: HookBuilder(
              builder: (context) {
                final blockTabScroll = useState<bool>(false);

                return TabBarView(
                  controller: tabController,
                  physics: blockTabScroll.value
                      ? const NeverScrollableScrollPhysics()
                      : null,
                  children: [
                    for (final section in PhotoPlanningSection.values)
                      switch (section) {
                        PhotoPlanningSection.profile =>
                          PhotoPlanningProfileSection(
                            blockTabScroll: (value) =>
                                blockTabScroll.value = value,
                          ),
                        PhotoPlanningSection.card => PhotoPlanningCardSection(
                            blockTabScroll: (value) =>
                                blockTabScroll.value = value,
                          ),
                      },
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Consumer<UserProfileProvider>(
                  builder: (context, provider, _) {
                    final isActive = provider.isProfilePhotoReady &&
                        provider.isCardPhotoReady;

                    return PrimaryButton(
                      backgroundColor:
                          isActive ? AppColors.blue : AppColors.blueOpacity25,
                      label: Text(
                        'Add Photos',
                        style: MontserratTextStyles.label13Bold.copyWith(
                          color: AppColors.black3,
                        ),
                      ),
                      onTap: isActive ? Navigator.of(context).maybePop : null,
                    );
                  },
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  backgroundColor: AppColors.grey,
                  label: Text(
                    'Preview photo',
                    style: MontserratTextStyles.label13Regular.copyWith(
                      color: AppColors.grey3,
                    ),
                  ),
                  onTap: () async {
                    const sectionValues = PhotoPlanningSection.values;
                    final currentSection = sectionValues[tabController.index];

                    final provider = context.read<UserProfileProvider>();

                    final photo = switch (currentSection) {
                      PhotoPlanningSection.profile => await provider
                          .profilePhotoScreenshotController
                          .capture(),
                      PhotoPlanningSection.card =>
                        await provider.cardPhotoScreenshotController.capture(),
                    };

                    if (photo == null) return;

                    await Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => switch (currentSection) {
                          PhotoPlanningSection.profile =>
                            PreviewPhotoPlanningProfileScreen(photo: photo),
                          PhotoPlanningSection.card =>
                            PreviewPhotoPlanningCardScreen(photo: photo),
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  backgroundColor: AppColors.grey,
                  label: Text(
                    'Select other photo from library',
                    style: MontserratTextStyles.label13Regular.copyWith(
                      color: AppColors.grey3,
                    ),
                  ),
                  onTap: () async {
                    try {
                      final filePickService = context.read<FilePickService>();
                      final photo = await filePickService.pickPhoto();

                      if (photo == null) return;

                      final userProfileProvider =
                          context.read<UserProfileProvider>();
                      userProfileProvider.setPickedPhoto(photo);
                    } catch (_) {}
                  },
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  backgroundColor: AppColors.darkGrey,
                  label: Text(
                    'CANCEL',
                    style: MontserratTextStyles.label13ExtraBold.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  onTap: () {
                    final userProfileProvider =
                        context.read<UserProfileProvider>();
                    userProfileProvider.resetPhotoPlanning();
                    Navigator.of(context).maybePop();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 42),
        ],
      ),
    );
  }
}

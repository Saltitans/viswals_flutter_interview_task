import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viswals_flutter_interview_task/state/user_profile_provider.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/montserrat_text_styles.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_checkbox.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/interactive_circular_image_previewer.dart';

class PhotoPlanningProfileSection extends StatefulWidget {
  const PhotoPlanningProfileSection({
    super.key,
    required this.blockTabScroll,
  });

  final ValueSetter<bool> blockTabScroll;

  @override
  State<PhotoPlanningProfileSection> createState() =>
      _PhotoPlanningProfileSectionState();
}

class _PhotoPlanningProfileSectionState
    extends State<PhotoPlanningProfileSection>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<UserProfileProvider>(
      builder: (context, provider, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 32),
            Flexible(
              child: InteractiveCircularImagePreviewer(
                photo: provider.pickedPhoto!,
                photoController: provider.profilePhotoController,
                screenshotController: provider.profilePhotoScreenshotController,
                outerBorderColor: provider.isProfilePhotoReady
                    ? AppColors.blue
                    : AppColors.grey,
                onStartInteraction: () {
                  widget.blockTabScroll.call(true);
                  provider.checkProfilePhoto(value: false, photo: null);
                },
                onEndInteraction: () => widget.blockTabScroll.call(false),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'PROFILE PHOTO IS NOW READY',
              style: MontserratTextStyles.label9Regular
                  .copyWith(color: AppColors.blue),
            ),
            const SizedBox(height: 8),
            Text(
              "LET'S MOVE ON FOR NEXT PHOTO",
              style: MontserratTextStyles.label9Regular
                  .copyWith(color: AppColors.grey4),
            ),
            const SizedBox(height: 32),
            AppCheckbox(
              value: provider.isProfilePhotoReady,
              onPress: (value) async {
                if (!value) {
                  provider.checkProfilePhoto(value: value, photo: null);
                  return;
                }
                try {
                  final photo =
                      await provider.profilePhotoScreenshotController.capture();
                  if (photo == null) return;
                  provider.checkProfilePhoto(value: value, photo: photo);
                } catch (_) {}
              },
            ),
            const SizedBox(height: 32),
          ],
        );
      },
    );
  }
}

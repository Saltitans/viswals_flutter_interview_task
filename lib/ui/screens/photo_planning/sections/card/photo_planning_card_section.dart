import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viswals_flutter_interview_task/state/user_profile_provider.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/montserrat_text_styles.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_checkbox.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/interactive_square_image_previewer.dart';

class PhotoPlanningCardSection extends StatefulWidget {
  const PhotoPlanningCardSection({
    super.key,
    required this.blockTabScroll,
  });

  final ValueSetter<bool> blockTabScroll;

  @override
  State<PhotoPlanningCardSection> createState() =>
      _PhotoPlanningCardSectionState();
}

class _PhotoPlanningCardSectionState extends State<PhotoPlanningCardSection>
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
              child: InteractiveSquareImagePreviewer(
                photo: provider.pickedPhoto!,
                photoController: provider.cardPhotoController,
                screenshotController: provider.cardPhotoScreenshotController,
                borderColor:
                    provider.isCardPhotoReady ? AppColors.blue : AppColors.grey,
                borderWidth: 10,
                onStartInteraction: () {
                  widget.blockTabScroll.call(true);
                  provider.checkCardPhoto(value: false, photo: null);
                },
                onEndInteraction: () => widget.blockTabScroll.call(false),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'CROP YOUR PHOTO FOR SHOULDER-HEAD PORTRAIT',
              style: MontserratTextStyles.label9Regular
                  .copyWith(color: AppColors.blue),
            ),
            const SizedBox(height: 8),
            Text(
              'WHEN DONE SIMPLY CHECK THIS BUTTON',
              style: MontserratTextStyles.label9Regular
                  .copyWith(color: AppColors.grey),
            ),
            const SizedBox(height: 32),
            AppCheckbox(
              value: provider.isCardPhotoReady,
              onPress: (value) async {
                if (!value) {
                  provider.checkCardPhoto(value: value, photo: null);
                  return;
                }
                try {
                  final photo =
                      await provider.cardPhotoScreenshotController.capture();
                  if (photo == null) return;
                  provider.checkCardPhoto(value: value, photo: photo);
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

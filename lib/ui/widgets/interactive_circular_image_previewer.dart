import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:screenshot/screenshot.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_loading_indicator.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/circular_image_border.dart';

class InteractiveCircularImagePreviewer extends StatelessWidget {
  const InteractiveCircularImagePreviewer({
    super.key,
    this.isInteractable = true,
    this.dimension,
    required this.photo,
    this.photoController,
    this.screenshotController,
    this.outerBorderColor = AppColors.grey,
    this.innerBorderColor = AppColors.black5,
    this.onStartInteraction,
    this.onEndInteraction,
  });

  final bool isInteractable;
  final double? dimension;
  final XFile photo;
  final PhotoViewController? photoController;
  final ScreenshotController? screenshotController;
  final Color outerBorderColor;
  final Color innerBorderColor;
  final VoidCallback? onStartInteraction;
  final VoidCallback? onEndInteraction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final effectiveHeight = dimension ?? constraints.maxHeight;

        return SizedBox.square(
          dimension: effectiveHeight,
          child: CircularImageBorder(
            outerBorderColor: outerBorderColor,
            innerBorderColor: innerBorderColor,
            child: Screenshot(
              controller: screenshotController ?? ScreenshotController(),
              child: IgnorePointer(
                ignoring: !isInteractable,
                child: PhotoView(
                  imageProvider: FileImage(File(photo.path)),
                  controller: photoController,
                  strictScale: false,
                  onTapDown: (context, _, __) {
                    HapticFeedback.mediumImpact();
                    onStartInteraction?.call();
                  },
                  enablePanAlways: true,
                  enableRotation: true,
                  onScaleEnd: (context, _, __) => onEndInteraction?.call(),
                  loadingBuilder: (context, _) =>
                      const Center(child: AppLoadingIndicator()),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

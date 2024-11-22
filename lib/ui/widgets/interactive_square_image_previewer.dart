import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:screenshot/screenshot.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_loading_indicator.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/square_image_border.dart';

class InteractiveSquareImagePreviewer extends StatelessWidget {
  const InteractiveSquareImagePreviewer({
    super.key,
    this.isInteractable = true,
    this.width,
    this.height,
    required this.photo,
    this.photoController,
    this.screenshotController,
    this.borderColor = AppColors.grey,
    required this.borderWidth,
    this.onStartInteraction,
    this.onEndInteraction,
  });

  final bool isInteractable;
  final double? width;
  final double? height;
  final XFile photo;
  final PhotoViewController? photoController;
  final ScreenshotController? screenshotController;
  final Color borderColor;
  final double borderWidth;
  final VoidCallback? onStartInteraction;
  final VoidCallback? onEndInteraction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final effectiveHeight = height ?? constraints.maxHeight;
        final effectiveWidth = width ?? (effectiveHeight * 1.159);

        return SizedBox(
          height: effectiveHeight,
          width: effectiveWidth,
          child: SquareImageBorder(
            borderColor: borderColor,
            borderWidth: borderWidth,
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

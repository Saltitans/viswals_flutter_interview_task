import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/montserrat_text_styles.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_loading_indicator.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/circular_image_border.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/fake_content.dart';

class PreviewPhotoPlanningProfileScreen extends StatelessWidget {
  const PreviewPhotoPlanningProfileScreen({
    super.key,
    required this.photo,
  });

  final Uint8List photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: AppColors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 58),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Spacer(),
                  Text(
                    'Preview Photo Planning',
                    style: MontserratTextStyles.label13Bold.copyWith(
                      color: AppColors.black3,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: Navigator.of(context).maybePop,
                        child: const Icon(
                          Icons.cancel,
                          size: 24,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: SizedBox.square(
                dimension: 186,
                child: CircularImageBorder(
                  outerBorderColor: AppColors.white,
                  innerBorderColor: AppColors.blue,
                  child: Image.memory(
                    photo,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) return child;
                      if (frame != null) return child;
                      return const Center(
                        child: AppLoadingIndicator(
                          color: AppColors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: AppColors.black4,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: SizedBox(height: 48),
                      ),
                    ),
                    const SizedBox(height: 23),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < 6; i++) ...[
                            _FakeTab(isSelected: i == 0),
                            if (i < 5) const SizedBox(width: 24),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final maxHeight = constraints.maxHeight;
                            final maxWidth = constraints.maxWidth;

                            final nBars = maxHeight ~/ (8 + 16);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var i = 0; i < nBars; i++) ...[
                                  FakeContent(
                                    color: AppColors.blueOpacity15,
                                    height: 8,
                                    width: switch (nBars - i) {
                                      1 || 2 => maxWidth * 0.50,
                                      3 || 4 => maxWidth * 0.75,
                                      _ => maxWidth,
                                    },
                                  ),
                                  if (i < nBars - 1) const SizedBox(height: 16),
                                ],
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 52),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FakeTab extends StatelessWidget {
  const _FakeTab({
    this.isSelected = false,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final width = 22.0 + random.nextInt(90 - 22);

    return Column(
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.blueOpacity15,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: SizedBox(width: width, height: 15),
        ),
        if (isSelected) ...[
          const SizedBox(height: 8),
          DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.darkGrey4,
              borderRadius: BorderRadius.all(Radius.circular(80)),
            ),
            child: SizedBox(width: width, height: 2),
          ),
        ],
      ],
    );
  }
}

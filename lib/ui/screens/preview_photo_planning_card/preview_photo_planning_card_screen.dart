import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/montserrat_text_styles.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_loading_indicator.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/fake_content.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/square_image_border.dart';

class PreviewPhotoPlanningCardScreen extends StatelessWidget {
  const PreviewPhotoPlanningCardScreen({
    super.key,
    required this.photo,
  });

  final Uint8List photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: AppColors.black6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 58),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    'Card Photo',
                    style: MontserratTextStyles.label13Bold.copyWith(
                      color: AppColors.blue,
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
                          color: AppColors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Expanded(
                child: ListView.separated(
                  itemCount: 6,
                  padding: const EdgeInsets.only(bottom: 25),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) => _FakeCard(photo: photo),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FakeCard extends StatelessWidget {
  const _FakeCard({
    required this.photo,
  });

  final Uint8List photo;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.blue),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10) +
            const EdgeInsets.only(left: 10) +
            const EdgeInsets.only(right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 108,
              height: 93,
              child: SquareImageBorder(
                borderColor: AppColors.white,
                borderWidth: 4,
                child: Image.memory(
                  photo,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) return child;
                    if (frame != null) return child;
                    return const Center(
                      child: AppLoadingIndicator(),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.maxWidth;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FakeContent(
                        color: AppColors.black5Opacity15,
                        height: 16,
                        width: maxWidth * 0.50,
                      ),
                      const SizedBox(height: 4),
                      FakeContent(
                        color: AppColors.black5Opacity15,
                        height: 11,
                        width: maxWidth * 0.30,
                      ),
                      const SizedBox(height: 17),
                      FakeContent(
                        color: AppColors.black5Opacity15,
                        height: 8,
                        width: maxWidth,
                      ),
                      const SizedBox(height: 4),
                      FakeContent(
                        color: AppColors.black5Opacity15,
                        height: 8,
                        width: maxWidth,
                      ),
                      const SizedBox(height: 4),
                      FakeContent(
                        color: AppColors.black5Opacity15,
                        height: 8,
                        width: maxWidth,
                      ),
                      const SizedBox(height: 4),
                      FakeContent(
                        color: AppColors.black5Opacity15,
                        height: 8,
                        width: maxWidth,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

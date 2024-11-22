import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/montserrat_text_styles.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  const AppCircularProgressIndicator({
    super.key,
    required this.dimension,
    required this.totalSteps,
    this.selectedStep,
    required this.stepCompletenessChecker,
    required this.completenessPercentage,
    this.stepSpacer = 5.0,
    this.stepPainterStrokeWidth = 5.0,
    this.stepUnselectedColor = AppColors.darkGrey,
    this.stepSelectedColor = AppColors.blue,
    this.stepHighlightColor = AppColors.black,
    this.dotRadius = 4.0,
    this.dotColor = AppColors.blue,
    this.dotStepSpacer = 10.0,
    this.progressIndicatorStepSpacer = 2.0,
    this.progressIndicatorPainterStrokeWidth = 20.0,
    this.progressIndicatorBackgroundColor = AppColors.grey,
    this.progressIndicatorForegroundColor = AppColors.blue,
    this.percentageTextStyle,
    this.percentageColor = AppColors.white,
  });

  final double dimension;
  final int totalSteps;
  final int? selectedStep;
  final bool Function(int) stepCompletenessChecker;
  final double completenessPercentage;
  final double stepSpacer;
  final double stepPainterStrokeWidth;
  final Color stepUnselectedColor;
  final Color stepSelectedColor;
  final Color stepHighlightColor;
  final double dotRadius;
  final Color dotColor;
  final double dotStepSpacer;
  final double progressIndicatorStepSpacer;
  final double progressIndicatorPainterStrokeWidth;
  final Color progressIndicatorBackgroundColor;
  final Color progressIndicatorForegroundColor;
  final TextStyle? percentageTextStyle;
  final Color percentageColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: CustomPaint(
        painter: _AppCircularProgressIndicatorCustomPainter(
          totalSteps: totalSteps,
          selectedStep: selectedStep,
          stepCompletenessChecker: stepCompletenessChecker,
          completenessPercentage: completenessPercentage,
          stepSpacer: stepSpacer,
          stepPainterStrokeWidth: stepPainterStrokeWidth,
          stepUnselectedColor: stepUnselectedColor,
          stepSelectedColor: stepSelectedColor,
          stepHighlightColor: stepHighlightColor,
          dotRadius: dotRadius,
          dotColor: dotColor,
          dotStepSpacer: dotStepSpacer,
          progressIndicatorStepSpacer: progressIndicatorStepSpacer,
          progressIndicatorPainterStrokeWidth:
              progressIndicatorPainterStrokeWidth,
          progressIndicatorBackgroundColor: progressIndicatorBackgroundColor,
          progressIndicatorForegroundColor: progressIndicatorForegroundColor,
          percentageTextStyle: percentageTextStyle,
          percentageColor: percentageColor,
        ),
      ),
    );
  }
}

class _AppCircularProgressIndicatorCustomPainter extends CustomPainter {
  _AppCircularProgressIndicatorCustomPainter({
    required this.totalSteps,
    required this.selectedStep,
    required this.stepCompletenessChecker,
    required this.completenessPercentage,
    required this.stepSpacer,
    required this.stepPainterStrokeWidth,
    required this.stepUnselectedColor,
    required this.stepSelectedColor,
    required this.stepHighlightColor,
    required this.dotRadius,
    required this.dotColor,
    required this.dotStepSpacer,
    required this.progressIndicatorStepSpacer,
    required this.progressIndicatorPainterStrokeWidth,
    required this.progressIndicatorBackgroundColor,
    required this.progressIndicatorForegroundColor,
    required this.percentageTextStyle,
    required this.percentageColor,
  });

  final int totalSteps;
  final int? selectedStep;
  final bool Function(int) stepCompletenessChecker;
  final double completenessPercentage;
  final double stepSpacer;
  final double stepPainterStrokeWidth;
  final Color stepUnselectedColor;
  final Color stepSelectedColor;
  final Color stepHighlightColor;
  final double dotRadius;
  final Color dotColor;
  final double dotStepSpacer;
  final double progressIndicatorStepSpacer;
  final double progressIndicatorPainterStrokeWidth;
  final Color progressIndicatorBackgroundColor;
  final Color progressIndicatorForegroundColor;
  final TextStyle? percentageTextStyle;
  final Color percentageColor;

  @override
  void paint(Canvas canvas, Size size) {
    const twoPI = 2 * math.pi;

    final dimension = size.width;
    final radius = dimension / 2;

    final stepSpacerSweepAngle = stepSpacer / radius;

    final stepSweepAngle =
        (twoPI - (totalSteps * stepSpacerSweepAngle)) / totalSteps;

    final stepPainter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stepPainterStrokeWidth;

    final stepOutlinerPainter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stepPainterStrokeWidth + 10
      ..color = stepHighlightColor;

    final dotPainter = Paint()
      ..style = PaintingStyle.fill
      ..color = dotColor;

    final stepRectSize = dimension - (2 * stepPainterStrokeWidth / 2);
    final stepRect = Rect.fromCenter(
      center: Offset(radius, radius),
      width: stepRectSize,
      height: stepRectSize,
    );

    final progressIndicatorBackgroundPainter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = progressIndicatorPainterStrokeWidth
      ..color = progressIndicatorBackgroundColor;

    final progressIndicatorForegroundPainter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = progressIndicatorPainterStrokeWidth
      ..color = progressIndicatorForegroundColor;

    final progressIndicatorRectSize = dimension -
        (4 * (stepPainterStrokeWidth / 2)) -
        (2 * progressIndicatorStepSpacer) -
        progressIndicatorPainterStrokeWidth;
    final progressIndicatorRectRadius = progressIndicatorRectSize / 2;
    final progressIndicatorRect = Rect.fromCenter(
      center: Offset(radius, radius),
      width: progressIndicatorRectSize,
      height: progressIndicatorRectSize,
    );

    final progressIndicatorForegroundCapSweepAngle =
        (progressIndicatorPainterStrokeWidth / 2) / progressIndicatorRectRadius;

    canvas.drawArc(
      progressIndicatorRect,
      0,
      twoPI,
      false,
      progressIndicatorBackgroundPainter,
    );

    canvas.drawArc(
      progressIndicatorRect,
      -math.pi / 2 + progressIndicatorForegroundCapSweepAngle,
      (completenessPercentage / 100) * twoPI,
      false,
      progressIndicatorForegroundPainter,
    );

    for (var i = 0; i < totalSteps; i++) {
      final isStepCompleted = stepCompletenessChecker.call(i + 1);

      final startAngle = -(math.pi / 2) +
          (stepSpacerSweepAngle / 2) +
          (i * (stepSweepAngle + stepSpacerSweepAngle));

      if (selectedStep == i + 1 && isStepCompleted) {
        canvas.drawArc(
          stepRect,
          startAngle - stepSpacerSweepAngle,
          stepSweepAngle + 2 * stepSpacerSweepAngle,
          false,
          stepOutlinerPainter,
        );
      }

      canvas.drawArc(
        stepRect,
        startAngle,
        stepSweepAngle,
        false,
        stepPainter
          ..color = isStepCompleted ? stepSelectedColor : stepUnselectedColor,
      );

      final isSelectedStep = selectedStep == i + 1;
      if (!isSelectedStep) continue;

      final dotCenter = Offset(
        radius +
            ((radius + dotStepSpacer + dotRadius) *
                math.cos(startAngle + (stepSweepAngle / 2))),
        radius +
            ((radius + dotStepSpacer + dotRadius) *
                math.sin(startAngle + (stepSweepAngle / 2))),
      );

      canvas.drawCircle(dotCenter, dotRadius, dotPainter);
    }

    final percentageTextPainter = TextPainter(
      text: TextSpan(
        text: '${completenessPercentage.toStringAsFixed(0)}%',
        style: percentageTextStyle?.copyWith(color: percentageColor) ??
            MontserratTextStyles.label32Black.copyWith(color: percentageColor),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    percentageTextPainter.layout();

    final xCenter = (dimension - percentageTextPainter.width) / 2;
    final yCenter = (dimension - percentageTextPainter.height) / 2;
    final offset = Offset(xCenter, yCenter);
    percentageTextPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}

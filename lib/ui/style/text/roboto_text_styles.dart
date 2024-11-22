import 'package:flutter/widgets.dart';
import 'package:viswals_flutter_interview_task/gen/fonts.gen.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';

abstract final class RobotoTextStyles {
  static TextStyle get label13Regular => const TextStyle(
        fontFamily: GenFontFamily.roboto,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 18 / 13,
        leadingDistribution: TextLeadingDistribution.even,
        color: AppColors.black,
      );

  static TextStyle get label9Regular => const TextStyle(
        fontFamily: GenFontFamily.roboto,
        fontSize: 9,
        fontWeight: FontWeight.w400,
        height: 11 / 9,
        leadingDistribution: TextLeadingDistribution.even,
        color: AppColors.black,
      );
}

import 'package:flutter/widgets.dart';
import 'package:viswals_flutter_interview_task/gen/fonts.gen.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';

abstract final class MontserratTextStyles {
  static TextStyle get label32Black => const TextStyle(
        fontFamily: GenFontFamily.montserrat,
        fontSize: 32,
        fontWeight: FontWeight.w900,
        height: 39 / 32,
        leadingDistribution: TextLeadingDistribution.even,
        color: AppColors.black,
      );

  static TextStyle get label24Black => const TextStyle(
        fontFamily: GenFontFamily.montserrat,
        fontSize: 24,
        fontWeight: FontWeight.w900,
        height: 29 / 24,
        leadingDistribution: TextLeadingDistribution.even,
        color: AppColors.black,
      );

  static TextStyle get label20Black => const TextStyle(
        fontFamily: GenFontFamily.montserrat,
        fontSize: 20,
        fontWeight: FontWeight.w900,
        height: 24 / 20,
        leadingDistribution: TextLeadingDistribution.even,
        color: AppColors.black,
      );

  static TextStyle get label13Black => const TextStyle(
        fontFamily: GenFontFamily.montserrat,
        fontSize: 13,
        fontWeight: FontWeight.w900,
        height: 16 / 13,
        leadingDistribution: TextLeadingDistribution.even,
        color: AppColors.black,
      );

  static TextStyle get label11Black => const TextStyle(
        fontFamily: GenFontFamily.montserrat,
        fontSize: 11,
        fontWeight: FontWeight.w900,
        height: 14 / 11,
        leadingDistribution: TextLeadingDistribution.even,
        color: AppColors.black,
      );

  static TextStyle get label13ExtraBold => const TextStyle(
        fontFamily: GenFontFamily.montserrat,
        fontSize: 13,
        fontWeight: FontWeight.w800,
        height: 16 / 13,
        leadingDistribution: TextLeadingDistribution.even,
        color: AppColors.black,
      );

  static TextStyle get label13Bold => const TextStyle(
        fontFamily: GenFontFamily.montserrat,
        fontSize: 13,
        fontWeight: FontWeight.w700,
        height: 16 / 13,
        leadingDistribution: TextLeadingDistribution.even,
        color: AppColors.black,
      );

  static TextStyle get label13Regular => const TextStyle(
        fontFamily: GenFontFamily.montserrat,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 16 / 13,
        leadingDistribution: TextLeadingDistribution.even,
        color: AppColors.black,
      );

  static TextStyle get label9Regular => const TextStyle(
        fontFamily: GenFontFamily.montserrat,
        fontSize: 9,
        fontWeight: FontWeight.w400,
        height: 11 / 9,
        leadingDistribution: TextLeadingDistribution.even,
        color: AppColors.black,
      );
}

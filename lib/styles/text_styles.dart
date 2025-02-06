import 'package:flutter/material.dart';
import 'package:vidres_app/utils/constants/color_constants.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/fonts.dart';

class TextStyles {
  static TextStyle kLightPoppins({
    double fontSize = FontSizes.k20FontSize,
    Color color = kColorTextPrimary,
    FontWeight fontWeight = FontWeight.w300,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: Fonts.poppinsLight,
    );
  }

  static TextStyle kRegularPoppins({
    double fontSize = FontSizes.k20FontSize,
    Color color = kColorTextPrimary,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: Fonts.poppinsRegular,
    );
  }

  static TextStyle kMediumPoppins({
    double fontSize = FontSizes.k20FontSize,
    Color color = kColorTextPrimary,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: Fonts.poppinsMedium,
    );
  }

  static TextStyle kSemiBoldPoppins({
    double fontSize = FontSizes.k20FontSize,
    Color color = kColorTextPrimary,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: Fonts.poppinsSemiBold,
    );
  }

  static TextStyle kBoldPoppins({
    double fontSize = FontSizes.k20FontSize,
    Color color = kColorTextPrimary,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: Fonts.poppinsBold,
    );
  }
}

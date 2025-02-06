import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/utils/constants/color_constants.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';

void showErrorSnackbar(
  String title,
  String message,
) {
  Get.snackbar(
    '',
    '',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: kColorRed,
    duration: const Duration(
      seconds: 3,
    ),
    margin: AppPaddings.p10,
    borderRadius: 15,
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
    reverseAnimationCurve: Curves.easeInBack,
    animationDuration: const Duration(
      milliseconds: 750,
    ),
    titleText: Text(
      title,
      style: TextStyles.kMediumPoppins(
        color: kColorWhite,
        fontSize: FontSizes.k20FontSize,
      ),
    ),
    messageText: Text(
      message,
      style: TextStyles.kRegularPoppins(
        fontSize: FontSizes.k16FontSize,
        color: kColorWhite,
      ),
    ),
    mainButton: TextButton(
      onPressed: () {
        Get.back();
      },
      child: Text(
        'OK',
        style: TextStyles.kMediumPoppins(
          color: kColorWhite,
          fontSize: FontSizes.k24FontSize,
        ),
      ),
    ),
  );
}

void showAlertSnackbar(
  String title,
  String message,
) {
  Get.snackbar(
    '',
    '',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.yellow,
    duration: const Duration(
      seconds: 5,
    ),
    margin: AppPaddings.p10,
    borderRadius: 15,
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
    reverseAnimationCurve: Curves.easeInBack,
    animationDuration: const Duration(
      milliseconds: 750,
    ),
    titleText: Text(
      title,
      style: TextStyles.kMediumPoppins(
        color: kColorTextPrimary,
        fontSize: FontSizes.k20FontSize,
      ),
    ),
    messageText: Text(
      message,
      style: TextStyles.kRegularPoppins(
        fontSize: FontSizes.k16FontSize,
        color: kColorTextPrimary,
      ),
    ),
    mainButton: TextButton(
      onPressed: () {
        Get.back();
      },
      child: Text(
        'OK',
        style: TextStyles.kMediumPoppins(
          color: kColorWhite,
          fontSize: FontSizes.k24FontSize,
        ),
      ),
    ),
  );
}

void showSuccessSnackbar(
  String title,
  String message,
) {
  Get.snackbar(
    '',
    '',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: kColorBlue,
    duration: const Duration(
      seconds: 3,
    ),
    margin: AppPaddings.p10,
    borderRadius: 15,
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
    reverseAnimationCurve: Curves.easeInBack,
    animationDuration: const Duration(
      milliseconds: 750,
    ),
    titleText: Text(
      title,
      style: TextStyles.kMediumPoppins(
        color: kColorWhite,
        fontSize: FontSizes.k20FontSize,
      ),
    ),
    messageText: Text(
      message,
      style: TextStyles.kRegularPoppins(
        fontSize: FontSizes.k16FontSize,
        color: kColorWhite,
      ),
    ),
    mainButton: TextButton(
      onPressed: () {
        Get.back();
      },
      child: Text(
        'OK',
        style: TextStyles.kMediumPoppins(
          color: kColorWhite,
          fontSize: FontSizes.k20FontSize,
        ),
      ),
    ),
  );
}

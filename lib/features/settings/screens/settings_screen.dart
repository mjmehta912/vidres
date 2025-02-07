import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/features/auth/reset_password/screens/reset_password_screen.dart';
import 'package:vidres_app/utils/constants/color_constants.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';
import 'package:vidres_app/utils/screen_utils/app_spacings.dart';
import 'package:vidres_app/utils/widgets/app_appbar.dart';
import 'package:vidres_app/utils/widgets/app_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.mobileNo,
  });

  final String mobileNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        title: 'Settings',
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: kColorTextPrimary,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: AppPaddings.p14,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppButton(
              title: 'Reset Password',
              buttonColor: kColorBackground,
              onPressed: () {
                Get.to(
                  () => ResetPasswordScreen(
                    mobileNo: mobileNo,
                  ),
                );
              },
            ),
            AppSpaces.v20,
            AppButton(
              title: 'Select Godown',
              buttonColor: kColorBackground,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

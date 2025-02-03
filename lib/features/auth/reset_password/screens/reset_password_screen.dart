import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/constants/color_constants.dart';
import 'package:vidres_app/features/auth/reset_password/controllers/reset_password_controller.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/extensions/app_size_extensions.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';
import 'package:vidres_app/utils/screen_utils/app_spacings.dart';
import 'package:vidres_app/widgets/app_button.dart';
import 'package:vidres_app/widgets/app_loading_overlay.dart';
import 'package:vidres_app/widgets/app_text_form_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({
    super.key,
    required this.mobileNo,
  });

  final String mobileNo;

  final ResetPasswordController _controller = Get.put(
    ResetPasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            backgroundColor: kColorBackground,
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: AppPaddings.p14,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vidres',
                          style: TextStyles.kBoldPoppins(
                            fontSize: FontSizes.k30FontSize,
                          ),
                        ),
                        Text(
                          'Ceramic Inventory',
                          style: TextStyles.kRegularPoppins(
                            fontSize: FontSizes.k24FontSize,
                          ),
                        ),
                        AppSpaces.v20,
                        Row(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: kColorWhite,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _controller.resetPasswordFormKey,
                          child: Padding(
                            padding: AppPaddings.p14,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppSpaces.v20,
                                Text(
                                  'Reset Password',
                                  style: TextStyles.kMediumPoppins(
                                    fontSize: FontSizes.k24FontSize,
                                  ),
                                ),
                                AppSpaces.v40,
                                Padding(
                                  padding: AppPaddings.ph20,
                                  child: Column(
                                    children: [
                                      Obx(
                                        () => AppTextFormField(
                                          controller:
                                              _controller.newPasswordController,
                                          hintText: 'New Password',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter a valid new password';
                                            }
                                            return null;
                                          },
                                          isObscure: _controller
                                              .obscuredNewPassword.value,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              _controller
                                                  .toggleNewPasswordVisibility();
                                            },
                                            icon: Icon(
                                              _controller
                                                      .obscuredNewPassword.value
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      AppSpaces.v16,
                                      Obx(
                                        () => AppTextFormField(
                                          controller: _controller
                                              .confirmPasswordController,
                                          hintText: 'Confirm Password',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please confirm your password';
                                            }
                                            if (value !=
                                                _controller
                                                    .newPasswordController
                                                    .text) {
                                              return 'Passwords do not match';
                                            }
                                            return null;
                                          },
                                          isObscure: _controller
                                              .obscuredConfirmPassword.value,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              _controller
                                                  .toggleConfirmPasswordVisibility();
                                            },
                                            icon: Icon(
                                              _controller
                                                      .obscuredConfirmPassword
                                                      .value
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AppSpaces.v40,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppButton(
                                      title: 'Reset Password',
                                      onPressed: () {
                                        _controller.hasAttemptedSubmit.value =
                                            true;
                                        if (_controller
                                            .resetPasswordFormKey.currentState!
                                            .validate()) {
                                          _controller.resetPassword(
                                            mobileNumber: mobileNo,
                                          );
                                        }
                                      },
                                      buttonWidth: 0.75.screenWidth,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(
          () => AppLoadingOverlay(
            isLoading: _controller.isLoading.value,
          ),
        ),
      ],
    );
  }
}

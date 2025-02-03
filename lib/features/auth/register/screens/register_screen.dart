import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vidres_app/constants/color_constants.dart';
import 'package:vidres_app/features/auth/register/controllers/register_controller.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/extensions/app_size_extensions.dart';
import 'package:vidres_app/utils/formatters/text_input_formatters.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';
import 'package:vidres_app/utils/screen_utils/app_spacings.dart';
import 'package:vidres_app/widgets/app_button.dart';
import 'package:vidres_app/widgets/app_loading_overlay.dart';
import 'package:vidres_app/widgets/app_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({
    super.key,
  });

  final RegisterController _controller = Get.put(
    RegisterController(),
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
                          key: _controller.registerFormKey,
                          child: Padding(
                            padding: AppPaddings.p14,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppSpaces.v20,
                                Text(
                                  'Create Account',
                                  style: TextStyles.kMediumPoppins(
                                    fontSize: FontSizes.k24FontSize,
                                  ),
                                ),
                                AppSpaces.v30,
                                Padding(
                                  padding: AppPaddings.ph20,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 0.4.screenWidth,
                                            child: AppTextFormField(
                                              controller: _controller
                                                  .firstNameController,
                                              hintText: 'First Name',
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please enter your first name';
                                                }
                                                return null;
                                              },
                                              inputFormatters: [
                                                TitleCaseTextInputFormatter(),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 0.4.screenWidth,
                                            child: AppTextFormField(
                                              controller: _controller
                                                  .lastNameController,
                                              hintText: 'Last Name',
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please enter your last name';
                                                }
                                                return null;
                                              },
                                              inputFormatters: [
                                                TitleCaseTextInputFormatter(),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      AppSpaces.v12,
                                      AppTextFormField(
                                        controller:
                                            _controller.mobileNumberController,
                                        hintText: 'Mobile Number',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your mobile number';
                                          }
                                          if (value.length != 10) {
                                            return 'Please enter a 10-digit mobile number';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: [
                                          MobileNumberInputFormatter(),
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                      ),
                                      AppSpaces.v12,
                                      Obx(
                                        () => AppTextFormField(
                                          controller:
                                              _controller.passwordController,
                                          hintText: 'Password',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter a password';
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
                                      AppSpaces.v12,
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
                                                    .passwordController.text) {
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
                                AppSpaces.v30,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppButton(
                                      title: 'Register',
                                      onPressed: () {
                                        _controller.hasAttemptedSubmit.value =
                                            true;
                                        if (_controller
                                            .registerFormKey.currentState!
                                            .validate()) {
                                          _controller.registerUser();
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

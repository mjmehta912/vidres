import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vidres_app/utils/constants/color_constants.dart';
import 'package:vidres_app/features/auth/login/controllers/login_controller.dart';
import 'package:vidres_app/features/auth/register/screens/register_screen.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/extensions/app_size_extensions.dart';
import 'package:vidres_app/utils/formatters/text_input_formatters.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';
import 'package:vidres_app/utils/screen_utils/app_spacings.dart';
import 'package:vidres_app/utils/widgets/app_button.dart';
import 'package:vidres_app/utils/widgets/app_loading_overlay.dart';
import 'package:vidres_app/utils/widgets/app_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    super.key,
  });

  final LoginController _controller = Get.put(
    LoginController(),
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
                          key: _controller.loginFormKey,
                          child: Padding(
                            padding: AppPaddings.p14,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppSpaces.v20,
                                Text(
                                  'Welcome Back!',
                                  style: TextStyles.kMediumPoppins(
                                    fontSize: FontSizes.k24FontSize,
                                  ),
                                ),
                                AppSpaces.v40,
                                Padding(
                                  padding: AppPaddings.ph20,
                                  child: Column(
                                    children: [
                                      AppTextFormField(
                                        controller:
                                            _controller.mobileNoController,
                                        hintText: 'Mobile No.',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter a mobile number';
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
                                      AppSpaces.v20,
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
                                          isObscure:
                                              _controller.obscuredText.value,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              _controller
                                                  .togglePasswordVisibility();
                                            },
                                            icon: Icon(
                                              _controller.obscuredText.value
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
                                      title: 'Login',
                                      onPressed: () {
                                        _controller.hasAttemptedLogin.value =
                                            true;
                                        if (_controller
                                            .loginFormKey.currentState!
                                            .validate()) {
                                          _controller.loginUser();
                                        }
                                      },
                                      buttonWidth: 0.75.screenWidth,
                                    ),
                                  ],
                                ),
                                AppSpaces.v20,
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'OR',
                                      style: TextStyles.kMediumPoppins(),
                                    ),
                                    AppSpaces.v20,
                                    AppButton(
                                      title: 'Register',
                                      buttonWidth: 0.75.screenWidth,
                                      buttonColor: kColorBackground,
                                      onPressed: () {
                                        Get.to(
                                          () => RegisterScreen(),
                                        );
                                      },
                                    ),
                                    Row(),
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

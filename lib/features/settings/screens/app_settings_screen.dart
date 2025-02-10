import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/features/auth/reset_password/screens/reset_password_screen.dart';
import 'package:vidres_app/features/settings/controllers/app_settings_controller.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/constants/color_constants.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';
import 'package:vidres_app/utils/screen_utils/app_spacings.dart';
import 'package:vidres_app/utils/widgets/app_appbar.dart';
import 'package:vidres_app/utils/widgets/app_dropdown.dart';
import 'package:vidres_app/utils/widgets/app_loading_overlay.dart';

class AppSettingsScreen extends StatelessWidget {
  AppSettingsScreen({
    super.key,
    required this.mobileNo,
  });

  final String mobileNo;

  final AppSettingsController _controller = Get.put(
    AppSettingsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: kColorWhite,
          appBar: AppAppbar(
            title: 'App Settings',
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
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => ResetPasswordScreen(
                        mobileNo: mobileNo,
                      ),
                    );
                  },
                  child: Card(
                    elevation: 0,
                    color: kColorWhite,
                    child: Padding(
                      padding: AppPaddings.p10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Reset Password',
                            style: TextStyles.kLightPoppins(
                              fontSize: FontSizes.k18FontSize,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: kColorTextPrimary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                GestureDetector(
                  onTap: () async {
                    await _controller.getToGodowns();
                    _controller.toggleVisibility();
                  },
                  child: Card(
                    elevation: 0,
                    color: kColorWhite,
                    child: Padding(
                      padding: AppPaddings.p10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Issue Godown',
                                style: TextStyles.kLightPoppins(
                                  fontSize: FontSizes.k18FontSize,
                                ),
                              ),
                              Obx(
                                () => Text(
                                  _controller
                                          .selectedToGodownName.value.isNotEmpty
                                      ? _controller.selectedToGodownName.value
                                      : 'Please select an issue godown',
                                  style: TextStyles.kMediumPoppins(
                                    fontSize: FontSizes.k16FontSize,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Obx(
                            () => _controller.isGodownDropdownVisible.value
                                ? Transform.rotate(
                                    angle: 3.14 / 2,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                      color: kColorTextPrimary,
                                    ),
                                  )
                                : Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: kColorTextPrimary,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AppSpaces.v10,
                Obx(
                  () {
                    return Visibility(
                      visible: _controller.isGodownDropdownVisible.value,
                      child: AppDropdown(
                        items: _controller.toGodownNames,
                        hintText: 'Select Issue Godown',
                        onChanged: (value) {
                          _controller.onToGodownSelected(value!);
                        },
                        selectedItem:
                            _controller.selectedToGodownName.value.isEmpty
                                ? null
                                : _controller.selectedToGodownName.value,
                      ),
                    );
                  },
                ),
              ],
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

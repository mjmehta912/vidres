import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/constants/color_constants.dart';
import 'package:vidres_app/features/auth/select_company/controllers/select_company_controller.dart';
import 'package:vidres_app/features/home/screens/home_screen.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/extensions/app_size_extensions.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';
import 'package:vidres_app/utils/screen_utils/app_spacings.dart';
import 'package:vidres_app/widgets/app_button.dart';
import 'package:vidres_app/widgets/app_dropdown.dart';

class SelectCompanyScreen extends StatelessWidget {
  SelectCompanyScreen({
    super.key,
  });

  final SelectCompanyController _controller = Get.put(
    SelectCompanyController(),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                      key: _controller.selectCompanyFormKey,
                      child: Padding(
                        padding: AppPaddings.p14,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppSpaces.v20,
                            Text(
                              'Pick Company & Year',
                              style: TextStyles.kMediumPoppins(
                                fontSize: FontSizes.k24FontSize,
                              ),
                            ),
                            AppSpaces.v40,
                            Obx(
                              () => AppDropdown(
                                items: [
                                  'c1',
                                  'c2',
                                  'c3',
                                  'c4',
                                ],
                                hintText: 'Company',
                                onChanged: (value) {},
                                selectedItem:
                                    _controller.selectedCompany.value.isNotEmpty
                                        ? _controller.selectedCompany.value
                                        : null,
                                validatorText: 'Please select a company',
                              ),
                            ),
                            AppSpaces.v20,
                            Obx(
                              () => AppDropdown(
                                items: [
                                  '2012',
                                  '2013',
                                  '2014',
                                  '2015',
                                ],
                                hintText: 'Year',
                                onChanged: (value) {},
                                selectedItem:
                                    _controller.selectedYear.value.isNotEmpty
                                        ? _controller.selectedYear.value
                                        : null,
                                validatorText: 'Please select an year',
                              ),
                            ),
                            AppSpaces.v40,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppButton(
                                  title: 'Continue',
                                  onPressed: () {
                                    if (_controller
                                        .selectCompanyFormKey.currentState!
                                        .validate()) {
                                      Get.offAll(
                                        () => HomeScreen(),
                                      );
                                    }
                                  },
                                  buttonWidth: 0.5.screenWidth,
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
    );
  }
}

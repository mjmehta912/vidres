import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/utils/constants/color_constants.dart';
import 'package:vidres_app/features/auth/login/models/company_dm.dart';
import 'package:vidres_app/features/auth/select_company/controllers/select_company_controller.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/extensions/app_size_extensions.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';
import 'package:vidres_app/utils/screen_utils/app_spacings.dart';
import 'package:vidres_app/utils/widgets/app_button.dart';
import 'package:vidres_app/utils/widgets/app_dropdown.dart';
import 'package:vidres_app/utils/widgets/app_loading_overlay.dart';

class SelectCompanyScreen extends StatefulWidget {
  const SelectCompanyScreen({
    super.key,
    required this.companies,
    required this.mobileNo,
  });

  final List<CompanyDm> companies;
  final String mobileNo;

  @override
  State<SelectCompanyScreen> createState() => _SelectCompanyScreenState();
}

class _SelectCompanyScreenState extends State<SelectCompanyScreen> {
  final SelectCompanyController _controller = Get.put(
    SelectCompanyController(),
  );

  @override
  void initState() {
    super.initState();
    if (widget.companies.length == 1) {
      _controller.selectedCoName.value = widget.companies.first.coName;
      _controller.selectedCid.value = widget.companies.first.cid;
      _controller.selectedCoCode.value = widget.companies.first.coCode;
      _controller.getYears();
    }
  }

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
                                Padding(
                                  padding: AppPaddings.ph20,
                                  child: Column(
                                    children: [
                                      Obx(
                                        () => AppDropdown(
                                          items: widget.companies
                                              .map(
                                                (com) => com.coName,
                                              )
                                              .toList(),
                                          hintText: 'Select Company',
                                          showSearchBox: false,
                                          onChanged: (value) {
                                            _controller.selectedCoName.value =
                                                value!;
                                            _controller.selectedCid.value =
                                                widget.companies
                                                    .firstWhere(
                                                      (company) =>
                                                          company.coName ==
                                                          value,
                                                    )
                                                    .cid;
                                            _controller.selectedCoCode.value =
                                                widget.companies
                                                    .firstWhere(
                                                      (company) =>
                                                          company.coName ==
                                                          value,
                                                    )
                                                    .coCode;

                                            if (widget.companies.length > 1) {
                                              _controller.getYears();
                                            }
                                          },
                                          selectedItem: _controller
                                                  .selectedCoName
                                                  .value
                                                  .isNotEmpty
                                              ? _controller.selectedCoName.value
                                              : null,
                                          validatorText:
                                              'Please select a company',
                                        ),
                                      ),
                                      AppSpaces.v16,
                                      Obx(
                                        () => AppDropdown(
                                          items: _controller.finYears,
                                          hintText: 'Fin Year',
                                          showSearchBox: false,
                                          onChanged: (value) => _controller
                                              .onYearSelected(value!),
                                          selectedItem: _controller
                                                  .selectedFinYear
                                                  .value
                                                  .isNotEmpty
                                              ? _controller
                                                  .selectedFinYear.value
                                              : null,
                                          validatorText:
                                              'Please select a financial year',
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
                                      title: 'Continue',
                                      onPressed: () {
                                        if (_controller
                                            .selectCompanyFormKey.currentState!
                                            .validate()) {
                                          _controller.getToken(
                                            mobileNumber: widget.mobileNo,
                                            cid: _controller
                                                .selectedCoCode.value!,
                                            yearId: _controller
                                                .selectedYearId.value,
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

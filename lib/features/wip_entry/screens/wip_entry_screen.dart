import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/features/wip_entry/controllers/wip_entry_controller.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/constants/color_constants.dart';
import 'package:vidres_app/utils/constants/image_constants.dart';
import 'package:vidres_app/utils/dialogs/app_dialogs.dart';
import 'package:vidres_app/utils/extensions/app_size_extensions.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';
import 'package:vidres_app/utils/screen_utils/app_spacings.dart';
import 'package:vidres_app/utils/widgets/app_appbar.dart';
import 'package:vidres_app/utils/widgets/app_button.dart';
import 'package:vidres_app/utils/widgets/app_dropdown.dart';
import 'package:vidres_app/utils/widgets/app_loading_overlay.dart';

class WipEntryScreen extends StatelessWidget {
  WipEntryScreen({
    super.key,
  });

  final WipEntryController _controller = Get.put(
    WipEntryController(),
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
            backgroundColor: kColorWhite,
            appBar: AppAppbar(
              title: 'WIP Entry',
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _controller.wipEntryFormKey,
                        child: Column(
                          children: [
                            Obx(
                              () => AppDropdown(
                                items: _controller.loadingPointNames,
                                hintText: 'Loading Point',
                                onChanged: (value) {
                                  _controller.onLoadingPointSelected(value!);
                                },
                                selectedItem: _controller
                                        .selectedLoadingPointName
                                        .value
                                        .isNotEmpty
                                    ? _controller.selectedLoadingPointName.value
                                    : null,
                                validatorText: 'Please select a loading point.',
                              ),
                            ),
                            AppSpaces.v14,
                            Obx(
                              () => Visibility(
                                visible: _controller
                                    .selectedLoadingPointCode.isNotEmpty,
                                child: AppDropdown(
                                  items: _controller.siloTypeNames,
                                  hintText: 'Silo Type',
                                  onChanged: (value) {
                                    _controller.onSiloTypeSelected(value!);
                                  },
                                  selectedItem: _controller
                                          .selectedSiloTypeName.value.isNotEmpty
                                      ? _controller.selectedSiloTypeName.value
                                      : null,
                                  validatorText: 'Please select a silo type.',
                                ),
                              ),
                            ),
                            AppSpaces.v14,
                            Obx(
                              () => Visibility(
                                visible: _controller
                                    .selectedSiloTypeCode.value.isNotEmpty,
                                child: AppDropdown(
                                  items: _controller.siloNames,
                                  hintText: 'Silo',
                                  onChanged: (value) {
                                    _controller.onSiloSelected(value!);
                                  },
                                  selectedItem: _controller
                                          .selectedSiloName.value.isNotEmpty
                                      ? _controller.selectedSiloName.value
                                      : null,
                                  validatorText: 'Please select a silo.',
                                ),
                              ),
                            ),
                            AppSpaces.v14,
                            Obx(
                              () => Visibility(
                                visible: _controller
                                    .selectedSiloCode.value.isNotEmpty,
                                child: AppDropdown(
                                  items: _controller.itemNames,
                                  hintText: 'Material',
                                  onChanged: (value) {
                                    _controller.onItemSelected(value!);
                                  },
                                  selectedItem: _controller
                                          .selectedItemName.value.isNotEmpty
                                      ? _controller.selectedItemName.value
                                      : null,
                                  validatorText: 'Please select a material.',
                                ),
                              ),
                            ),
                            AppSpaces.v14,
                            Obx(
                              () => Visibility(
                                visible:
                                    _controller.selectedItemCode.isNotEmpty,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    AppButton(
                                      title: 'Scan',
                                      buttonColor: kColorCard3Primary,
                                      buttonWidth: 0.5.screenWidth,
                                      onPressed: () {
                                        _controller.scanAndValidate();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            AppSpaces.v14,
                            Obx(
                              () => ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _controller.cards.length,
                                itemBuilder: (context, index) {
                                  final card = _controller.cards[index];

                                  return Card(
                                    color: kColorWhite,
                                    child: Padding(
                                      padding: AppPaddings.p10,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            card['CardNo'],
                                            style: TextStyles.kMediumPoppins(
                                              fontSize: FontSizes.k16FontSize,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _controller.cards.removeAt(index);
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: kColorRed,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: _controller.cards.isNotEmpty,
                      child: GestureDetector(
                        onTap: () {
                          if (_controller.wipEntryFormKey.currentState!
                              .validate()) {
                            if (_controller.cards.isNotEmpty) {
                              _controller.saveWipEntry();
                            } else {
                              showErrorSnackbar(
                                'Oops',
                                'Please scan a card to continue',
                              );
                            }
                          }
                        },
                        child: Stack(
                          children: [
                            Card(
                              elevation: 5,
                              color: kColorCard3Primary,
                              child: Padding(
                                padding: AppPaddings.p10,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Save \nWIP Entry',
                                          style: TextStyles.kSemiBoldPoppins(),
                                        ),
                                      ],
                                    ),
                                    CircleAvatar(
                                      radius: 12.5,
                                      backgroundColor: kColorCard3Secondary,
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 10,
                                        color: kColorCard3Primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: 60,
                              top: 0,
                              bottom: 0,
                              child: Image.asset(
                                kImageWipEntry,
                              ),
                            ),
                          ],
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

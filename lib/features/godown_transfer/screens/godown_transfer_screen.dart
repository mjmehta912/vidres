import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/features/godown_transfer/controllers/godown_transfer_controller.dart';
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

class GodownTransferScreen extends StatelessWidget {
  GodownTransferScreen({
    super.key,
  });

  final GodownTransferController _controller = Get.put(
    GodownTransferController(),
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
              title: 'Godown Transfer',
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
                        key: _controller.godownTransferFormKey,
                        child: Column(
                          children: [
                            Obx(
                              () => AppDropdown(
                                items: _controller.itemNames,
                                hintText: 'Items',
                                onChanged: (value) {
                                  _controller.onItemSelected(value!);
                                },
                                selectedItem: _controller
                                        .selectedItemName.value.isNotEmpty
                                    ? _controller.selectedItemName.value
                                    : null,
                                validatorText: 'Please select an item.',
                              ),
                            ),
                            AppSpaces.v14,
                            Obx(
                              () => Visibility(
                                visible: _controller
                                    .selectedItemCode.value.isNotEmpty,
                                child: AppDropdown(
                                  items: _controller.fromGodownNames,
                                  hintText: 'From Godown',
                                  onChanged: (value) {
                                    _controller.onFromGodownSelected(value!);
                                  },
                                  selectedItem: _controller
                                          .selectedFromGodownName
                                          .value
                                          .isNotEmpty
                                      ? _controller.selectedFromGodownName.value
                                      : null,
                                  validatorText: 'Please select from godown.',
                                ),
                              ),
                            ),
                            AppSpaces.v14,
                            Obx(
                              () => Visibility(
                                visible: _controller
                                    .selectedFromGodownCode.value.isNotEmpty,
                                child: AppDropdown(
                                  items: _controller.toGodownNames,
                                  hintText: 'To Godown',
                                  onChanged: (value) {
                                    _controller.onToGodownSelected(value!);
                                  },
                                  selectedItem: _controller
                                          .selectedToGodownName.value.isNotEmpty
                                      ? _controller.selectedToGodownName.value
                                      : null,
                                  validatorText: 'Please select to godown.',
                                ),
                              ),
                            ),
                            AppSpaces.v14,
                            Obx(
                              () => Visibility(
                                visible: _controller
                                    .selectedToGodownCode.value.isNotEmpty,
                                child: AppDropdown(
                                  items: _controller.toGodownLocationNames,
                                  hintText: 'To Godown Location',
                                  onChanged: (value) {
                                    _controller
                                        .onToGodownLocationSelected(value!);
                                  },
                                  selectedItem: _controller
                                          .selectedToGodownLocation
                                          .value
                                          .isNotEmpty
                                      ? _controller
                                          .selectedToGodownLocation.value
                                      : null,
                                  validatorText:
                                      'Please select to godown location.',
                                ),
                              ),
                            ),
                            AppSpaces.v14,
                            Obx(
                              () => Visibility(
                                visible: _controller
                                    .selectedToGodownLocation.isNotEmpty,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    AppButton(
                                      title: 'Scan',
                                      buttonColor: kColorCard5Primary,
                                      buttonWidth: 0.5.screenWidth,
                                      onPressed: () {
                                        _controller.scanAndValidate();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                          if (_controller.godownTransferFormKey.currentState!
                              .validate()) {
                            if (_controller.cards.isNotEmpty) {
                              _controller.saveGodownTransferEntry();
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
                              color: kColorCard5Primary,
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
                                          'Save Godown \nTransfer Entry',
                                          style: TextStyles.kSemiBoldPoppins(),
                                        ),
                                      ],
                                    ),
                                    CircleAvatar(
                                      radius: 12.5,
                                      backgroundColor: kColorCard5Secondary,
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 10,
                                        color: kColorCard5Primary,
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
                                kImageGodownTransfer,
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/features/godown_transfer/models/godown_dm.dart';
import 'package:vidres_app/features/godown_transfer/models/godown_location_dm.dart';
import 'package:vidres_app/features/godown_transfer/models/item_dm.dart';
import 'package:vidres_app/features/godown_transfer/repos/godown_transfer_repo.dart';
import 'package:vidres_app/features/godown_transfer/screens/qr_scanner_screen_godown.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/constants/color_constants.dart';
import 'package:vidres_app/utils/dialogs/app_dialogs.dart';
import 'package:vidres_app/utils/extensions/app_size_extensions.dart';
import 'package:vidres_app/utils/helpers/sound_helper.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';
import 'package:vidres_app/utils/screen_utils/app_spacings.dart';
import 'package:vidres_app/utils/widgets/app_button.dart';

class GodownTransferController extends GetxController {
  var isLoading = false.obs;
  final godownTransferFormKey = GlobalKey<FormState>();

  var items = <ItemDm>[].obs;
  var itemNames = <String>[].obs;
  var selectedItemName = ''.obs;
  var selectedItemCode = ''.obs;

  var fromGodowns = <GodownDm>[].obs;
  var fromGodownNames = <String>[].obs;
  var selectedFromGodownName = ''.obs;
  var selectedFromGodownCode = ''.obs;

  var toGodowns = <GodownDm>[].obs;
  var toGodownNames = <String>[].obs;
  var selectedToGodownName = ''.obs;
  var selectedToGodownCode = ''.obs;

  var toGodownLocations = <GodownLocationDm>[].obs;
  var toGodownLocationNames = <String>[].obs;
  var selectedToGodownLocation = ''.obs;
  var selectedToGodownLocationSrNo = 0.obs;

  var cards = <Map<String, dynamic>>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getAllItems();
  }

  Future<void> getAllItems() async {
    try {
      isLoading.value = true;

      final fetchedItems = await GodownTransferRepo.getAllItems();

      items.assignAll(fetchedItems);
      itemNames.assignAll(
        fetchedItems.map(
          (item) => item.iName,
        ),
      );
    } catch (e) {
      if (e is Map<String, dynamic>) {
        showErrorSnackbar(
          'Error',
          e['message'],
        );
      } else {
        showErrorSnackbar(
          'Error',
          e.toString(),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void onItemSelected(String itemName) async {
    selectedItemName.value = itemName;
    final itemObj = items.firstWhere(
      (item) => item.iName == itemName,
    );

    selectedItemCode.value = itemObj.iCode;
    selectedFromGodownCode.value = '';
    selectedFromGodownName.value = '';
    await getFromGodowns(
      iCode: itemObj.iCode,
    );
  }

  Future<void> getFromGodowns({
    required String iCode,
  }) async {
    try {
      isLoading.value = true;

      final fetchedFromGodowns = await GodownTransferRepo.getFromGodowns(
        iCode: iCode,
      );

      fromGodowns.assignAll(fetchedFromGodowns);
      fromGodownNames.assignAll(
        fetchedFromGodowns.map(
          (gd) => gd.gdName,
        ),
      );
    } catch (e) {
      if (e is Map<String, dynamic>) {
        showErrorSnackbar(
          'Error',
          e['message'],
        );
      } else {
        showErrorSnackbar(
          'Error',
          e.toString(),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void onFromGodownSelected(String godownName) async {
    selectedFromGodownName.value = godownName;
    final fromGodownObj = fromGodowns.firstWhere(
      (gd) => gd.gdName == godownName,
    );

    selectedToGodownCode.value = '';
    selectedToGodownName.value = '';
    selectedFromGodownCode.value = fromGodownObj.gdCode;

    await getToGodowns();
  }

  Future<void> getToGodowns() async {
    try {
      isLoading.value = true;

      final fetchedToGodowns = await GodownTransferRepo.getToGodowns();

      toGodowns.assignAll(fetchedToGodowns);
      toGodownNames.assignAll(
        fetchedToGodowns.map(
          (gd) => gd.gdName,
        ),
      );
    } catch (e) {
      if (e is Map<String, dynamic>) {
        showErrorSnackbar(
          'Error',
          e['message'],
        );
      } else {
        showErrorSnackbar(
          'Error',
          e.toString(),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void onToGodownSelected(String godownName) async {
    selectedToGodownName.value = godownName;
    final toGodownObj = toGodowns.firstWhere(
      (gd) => gd.gdName == godownName,
    );

    selectedToGodownLocation.value = '';
    selectedToGodownLocationSrNo.value = 0;
    selectedToGodownCode.value = toGodownObj.gdCode;

    await getToGodownLocation(
      toGodownLocationCode: selectedToGodownCode.value,
    );
  }

  Future<void> getToGodownLocation({
    required String toGodownLocationCode,
  }) async {
    try {
      isLoading.value = true;

      final fetchedToGodownLocations =
          await GodownTransferRepo.getToGodownLocation(
        toGodownLocationCode: toGodownLocationCode,
      );

      toGodownLocations.assignAll(fetchedToGodownLocations);
      toGodownLocationNames.assignAll(
        fetchedToGodownLocations.map(
          (gdLoc) => gdLoc.gdLocation,
        ),
      );
    } catch (e) {
      if (e is Map<String, dynamic>) {
        showErrorSnackbar(
          'Error',
          e['message'],
        );
      } else {
        showErrorSnackbar(
          'Error',
          e.toString(),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void onToGodownLocationSelected(String godownLocation) async {
    selectedToGodownLocation.value = godownLocation;
    final toGodownLocationObj = toGodownLocations.firstWhere(
      (gdLoc) => gdLoc.gdLocation == godownLocation,
    );

    selectedToGodownLocationSrNo.value = toGodownLocationObj.srNo;
  }

  Future<void> scanAndValidate() async {
    try {
      isLoading.value = true;

      final scannedData = await Get.to(
        () => QrScannerScreenGodown(
          onScanResult: (scanResult) {
            Get.back(result: scanResult);
          },
          existingCardNumbers: Set.from(
            cards.map(
              (card) => card['CardNo'],
            ),
          ),
        ),
      );

      if (scannedData != null) {
        final response = await GodownTransferRepo.validateGodownTransfer(
          cardNo: scannedData,
          fromGodownCode: selectedFromGodownCode.value,
        );

        if (response['Stock'] != null && response['Stock'] > 0) {
          SoundHelper.playSuccessSound();
          cards.add(
            {
              'CardNo': scannedData,
            },
          );
        } else {
          SoundHelper.playFailureSound();
          showAlertSnackbar(
            'Not Available',
            'Item not available in the godown',
          );
        }
      }
    } catch (e) {
      SoundHelper.playFailureSound();
      if (e is Map<String, dynamic>) {
        showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: kColorWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: AppPaddings.p10,
                constraints: const BoxConstraints(
                  maxWidth: 300,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      e['message'],
                      style: TextStyles.kRegularPoppins(
                        color: kColorRed,
                        fontSize: FontSizes.k18FontSize,
                      ),
                    ),
                    AppSpaces.v20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppButton(
                          buttonWidth: 0.4.screenWidth,
                          buttonHeight: 40,
                          onPressed: () {
                            Get.back();
                          },
                          buttonColor: kColorCard5Primary,
                          title: 'OK',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        showErrorSnackbar(
          'Error',
          e.toString(),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveGodownTransferEntry() async {
    isLoading.value = true;

    try {
      var response = await GodownTransferRepo.saveGodownTransferEntry(
        iCode: selectedItemCode.value,
        fromGdCode: selectedFromGodownCode.value,
        toGdCode: selectedToGodownCode.value,
        toGdCodeLocation: selectedToGodownLocationSrNo.value.toString(),
        cards: cards,
      );

      if (response != null && response.containsKey('message')) {
        String message = response['message'];
        Get.back();
        showSuccessSnackbar(
          'Success',
          message,
        );
      }
    } catch (e) {
      if (e is Map<String, dynamic>) {
        showErrorSnackbar(
          'Error',
          e['message'],
        );
      } else {
        showErrorSnackbar(
          'Error',
          e.toString(),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
}

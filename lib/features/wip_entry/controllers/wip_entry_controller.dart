import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/features/wip_entry/models/item_silo_wise_dm.dart';
import 'package:vidres_app/features/wip_entry/models/loading_point_dm.dart';
import 'package:vidres_app/features/wip_entry/models/silo_dm.dart';
import 'package:vidres_app/features/wip_entry/models/silo_type_dm.dart';
import 'package:vidres_app/features/wip_entry/repos/wip_entry_repo.dart';
import 'package:vidres_app/features/wip_entry/screens/qr_scanner_screen_wip.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/constants/color_constants.dart';

import 'package:vidres_app/utils/dialogs/app_dialogs.dart';
import 'package:vidres_app/utils/extensions/app_size_extensions.dart';
import 'package:vidres_app/utils/helpers/sound_helper.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';
import 'package:vidres_app/utils/screen_utils/app_spacings.dart';
import 'package:vidres_app/utils/widgets/app_button.dart';

class WipEntryController extends GetxController {
  var isLoading = false.obs;
  final wipEntryFormKey = GlobalKey<FormState>();

  var loadingPoints = <LoadingPointDm>[].obs;
  var loadingPointNames = <String>[].obs;
  var selectedLoadingPointName = ''.obs;
  var selectedLoadingPointCode = ''.obs;

  var siloTypes = <SiloTypeDm>[].obs;
  var siloTypeNames = <String>[].obs;
  var selectedSiloTypeName = ''.obs;
  var selectedSiloTypeCode = ''.obs;

  var silos = <SiloDm>[].obs;
  var siloNames = <String>[].obs;
  var selectedSiloName = ''.obs;
  var selectedSiloCode = ''.obs;

  var items = <ItemSiloWiseDm>[].obs;
  var itemNames = <String>[].obs;
  var selectedItemName = ''.obs;
  var selectedItemCode = ''.obs;

  var cards = <Map<String, dynamic>>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getLoadingPoints();
  }

  Future<void> getLoadingPoints() async {
    try {
      isLoading.value = true;

      final fetchedLoadingPoints = await WipEntryRepo.getLoadingPoints();

      loadingPoints.assignAll(fetchedLoadingPoints);
      loadingPointNames.assignAll(
        fetchedLoadingPoints.map(
          (lp) => lp.lpName,
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

  void onLoadingPointSelected(String loadingPointName) async {
    selectedLoadingPointName.value = loadingPointName;
    final lpObj = loadingPoints.firstWhere(
      (lp) => lp.lpName == loadingPointName,
    );

    selectedLoadingPointCode.value = lpObj.lpCode;
    await getSiloTypes();
    if (selectedSiloTypeCode.value.isNotEmpty) {
      selectedSiloCode.value = '';
      selectedSiloName.value = '';
      selectedItemCode.value = '';
      selectedItemName.value = '';
      await getSilos(
        siloTypeCode: selectedSiloTypeCode.value,
        lpCode: selectedLoadingPointCode.value,
      );
    }
  }

  Future<void> getSiloTypes() async {
    try {
      isLoading.value = true;

      final fetchedSiloTypes = await WipEntryRepo.getSiloTypes();

      siloTypes.assignAll(fetchedSiloTypes);
      siloTypeNames.assignAll(
        fetchedSiloTypes.map(
          (siloType) => siloType.siloTypeName,
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

  void onSiloTypeSelected(String siloTypeName) async {
    selectedSiloTypeName.value = siloTypeName;
    final siloTypeObj = siloTypes.firstWhere(
      (siloType) => siloType.siloTypeName == siloTypeName,
    );

    selectedSiloTypeCode.value = siloTypeObj.siloTypeCode;
    selectedSiloCode.value = '';
    selectedSiloName.value = '';
    selectedItemCode.value = '';
    selectedItemName.value = '';
    await getSilos(
      siloTypeCode: selectedSiloTypeCode.value,
      lpCode: selectedLoadingPointCode.value,
    );
  }

  Future<void> getSilos({
    required String siloTypeCode,
    required String lpCode,
  }) async {
    try {
      isLoading.value = true;

      final fetchedSilos = await WipEntryRepo.getSilos(
        siloTypeCode: siloTypeCode,
        lpCode: lpCode,
      );

      silos.assignAll(fetchedSilos);
      siloNames.assignAll(
        fetchedSilos.map(
          (silo) => silo.siloName,
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

  void onSiloSelected(String siloName) async {
    selectedSiloName.value = siloName;
    final siloObj = silos.firstWhere(
      (silo) => silo.siloName == siloName,
    );

    selectedSiloCode.value = siloObj.siloCode;
    selectedItemCode.value = siloObj.iCode ?? '';
    selectedItemName.value = siloObj.iName ?? '';

    await getItemsSiloWise(
      siloCode: selectedSiloCode.value,
    );
  }

  Future<void> getItemsSiloWise({
    required String siloCode,
  }) async {
    try {
      isLoading.value = true;

      final fetchedItems = await WipEntryRepo.getItemsSiloWise(
        siloCode: siloCode,
      );

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
  }

  Future<void> scanAndValidate() async {
    try {
      isLoading.value = true;

      final scannedData = await Get.to(
        () => QrScannerScreenWip(
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
        final response = await WipEntryRepo.validateWip(
          cardNo: scannedData,
          iCode: selectedItemCode.value,
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
                          buttonColor: kColorCard3Primary,
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

  Future<void> saveWipEntry() async {
    isLoading.value = true;

    try {
      var response = await WipEntryRepo.saveWipEntry(
        iCode: selectedItemCode.value,
        lpCode: selectedLoadingPointCode.value,
        siloCode: selectedSiloCode.value,
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

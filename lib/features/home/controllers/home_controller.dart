import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vidres_app/features/auth/login/screens/login_screen.dart';
import 'package:vidres_app/features/issue_entry/repos/issue_entry_repo.dart';
import 'package:vidres_app/features/issue_entry/screens/issue_entry_qr_scanner_screen.dart';
import 'package:vidres_app/utils/dialogs/app_dialogs.dart';
import 'package:vidres_app/utils/helpers/secure_storage_helper.dart';
import 'package:vidres_app/utils/helpers/sound_helper.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var company = ''.obs;
  var mobileNo = ''.obs;

  @override
  void onInit() async {
    super.onInit();

    final storedCompany = await SecureStorageHelper.read('company');
    company.value = storedCompany ?? 'Ceramic Inventory';

    final storedMobileNo = await SecureStorageHelper.read('mobileNo');
    mobileNo.value = storedMobileNo ?? '';
  }

  Future<void> logoutUser() async {
    isLoading.value = true;
    try {
      await SecureStorageHelper.clearAll();

      Get.offAll(
        () => LoginScreen(),
      );

      showSuccessSnackbar(
        'Logged Out',
        'You have been successfully logged out.',
      );
    } catch (e) {
      showErrorSnackbar(
        'Logout Failed',
        'Something went wrong. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> scanAndValidateIssue() async {
    try {
      isLoading.value = true;

      await Get.to(
        () => IssueEntryQrScannerScreen(
          onScanResult: (scanResult, controller) async {
            await handleScan(scanResult, controller);
          },
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleScan(
    String scannedData,
    QRViewController controller,
  ) async {
    String gdCode =
        await SecureStorageHelper.read('selected_godown_code') ?? '';

    if (gdCode.isEmpty) {
      showErrorSnackbar(
        'Error',
        'Please select a godown in the app settings to continue.',
      );
      return;
    }

    try {
      final response = await IssueEntryRepo.validateIssue(
        cardNo: scannedData,
        gdCode: gdCode,
      );

      if (response['message'] != null) {
        SoundHelper.playSuccessSound();
        showSuccessSnackbar('Success', response['message']);
      }
    } catch (e) {
      SoundHelper.playFailureSound();
      showErrorSnackbar(
        'Error',
        e is Map<String, dynamic> ? e['message'] : e.toString(),
      );
    } finally {
      await Future.delayed(
        const Duration(
          seconds: 3,
        ),
      );
      await controller.resumeCamera();
    }
  }
}

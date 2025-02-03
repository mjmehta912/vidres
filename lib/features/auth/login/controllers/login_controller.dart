import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/features/auth/login/models/company_dm.dart';
import 'package:vidres_app/features/auth/login/repos/login_repo.dart';
import 'package:vidres_app/features/auth/select_company/screens/select_company_screen.dart';
import 'package:vidres_app/utils/dialogs/app_dialogs.dart';
import 'package:vidres_app/utils/helpers/device_helpers.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final loginFormKey = GlobalKey<FormState>();

  var obscuredText = true.obs;
  void togglePasswordVisibility() {
    obscuredText.value = !obscuredText.value;
  }

  var mobileNoController = TextEditingController();
  var passwordController = TextEditingController();
  var companies = <CompanyDm>[].obs;
  var hasAttemptedLogin = false.obs;

  @override
  void onInit() {
    super.onInit();
    setupValidationListeners();
  }

  void setupValidationListeners() {
    mobileNoController.addListener(validateForm);
    passwordController.addListener(validateForm);
  }

  void validateForm() {
    if (hasAttemptedLogin.value) {
      loginFormKey.currentState?.validate();
    }
  }

  Future<void> loginUser() async {
    isLoading.value = true;
    String? deviceId = await DeviceHelper().getDeviceId();
    if (deviceId == null) {
      showErrorSnackbar(
        'Login Failed',
        'Unable to fetch device ID.',
      );
      isLoading.value = false;
      return;
    }

    try {
      final fetchedCompanies = await LoginRepo.loginUser(
        mobileNo: mobileNoController.text,
        password: passwordController.text,
        fcmToken: '',
        deviceId: deviceId,
      );
      companies.assignAll(fetchedCompanies);

      Get.to(
        () => SelectCompanyScreen(
          companies: companies,
          mobileNo: mobileNoController.text,
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
}

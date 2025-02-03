import 'package:get/get.dart';
import 'package:vidres_app/features/auth/login/screens/login_screen.dart';
import 'package:vidres_app/utils/dialogs/app_dialogs.dart';
import 'package:vidres_app/utils/helpers/secure_storage_helper.dart';

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
}

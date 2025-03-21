import 'package:get/get.dart';
import 'package:vidres_app/features/godown_transfer/models/godown_dm.dart';
import 'package:vidres_app/features/issue_godown/repos/issue_godown_repo.dart';
import 'package:vidres_app/utils/dialogs/app_dialogs.dart';
import 'package:vidres_app/utils/helpers/secure_storage_helper.dart';

class IssueGodownController extends GetxController {
  var isLoading = false.obs;
  var toGodowns = <GodownDm>[].obs;
  var toGodownNames = <String>[].obs;
  var selectedToGodownName = ''.obs;
  var selectedToGodownCode = ''.obs;
  var isGodownDropdownVisible = false.obs;

  static const String godownNameKey = "selected_godown_name";
  static const String godownCodeKey = "selected_godown_code";

  @override
  void onInit() {
    super.onInit();
    _loadSavedGodown();
  }

  void toggleVisibility() {
    isGodownDropdownVisible.value = !isGodownDropdownVisible.value;
  }

  Future<void> getToGodowns() async {
    try {
      isLoading.value = true;

      final fetchedToGodowns = await IssueGodownRepo.getToGodowns();

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
    final toGodownObj = toGodowns.firstWhere((gd) => gd.gdName == godownName);

    selectedToGodownCode.value = toGodownObj.gdCode;

    // Save the selected values in secure storage
    await SecureStorageHelper.write(
      godownNameKey,
      godownName,
    );
    await SecureStorageHelper.write(
      godownCodeKey,
      toGodownObj.gdCode,
    );
  }

  Future<void> _loadSavedGodown() async {
    final savedGodownName = await SecureStorageHelper.read(godownNameKey);
    final savedGodownCode = await SecureStorageHelper.read(godownCodeKey);

    if (savedGodownName != null && savedGodownCode != null) {
      selectedToGodownName.value = savedGodownName;
      selectedToGodownCode.value = savedGodownCode;
    }
  }
}

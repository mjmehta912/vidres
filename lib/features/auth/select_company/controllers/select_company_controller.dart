import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/features/auth/select_company/models/year_dm.dart';
import 'package:vidres_app/features/auth/select_company/repos/select_company_repo.dart';
import 'package:vidres_app/features/home/screens/home_screen.dart';
import 'package:vidres_app/utils/dialogs/app_dialogs.dart';
import 'package:vidres_app/utils/helpers/secure_storage_helper.dart';

class SelectCompanyController extends GetxController {
  var isLoading = false.obs;
  final selectCompanyFormKey = GlobalKey<FormState>();

  var selectedCid = Rxn<int>();
  var selectedCoName = ''.obs;
  var selectedCoCode = Rxn<int>();
  var years = <YearDm>[].obs;
  var finYears = <String>[].obs;
  var selectedFinYear = ''.obs;
  var selectedYearId = 0.obs;

  Future<void> getYears() async {
    try {
      isLoading.value = true;

      final fetchedYears = await SelectCompanyRepo.getYears(
        coCode: selectedCoCode.value!,
      );

      years.assignAll(fetchedYears);
      finYears.assignAll(
        fetchedYears
            .map(
              (year) => year.finYear,
            )
            .toList(),
      );
    } catch (e) {
      showErrorSnackbar(
        'Error',
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onYearSelected(String finYear) {
    selectedFinYear.value = finYear;

    var yearObj = years.firstWhere(
      (year) => year.finYear == finYear,
    );

    selectedYearId.value = yearObj.yearId;
  }

  Future<void> getToken({
    required String mobileNumber,
    required int cid,
    required int yearId,
  }) async {
    isLoading.value = true;

    try {
      var response = await SelectCompanyRepo.getToken(
        mobileNumber: mobileNumber,
        cid: cid,
        yearId: yearId,
      );

      await SecureStorageHelper.write(
        'userType',
        response['userType'].toString(),
      );
      await SecureStorageHelper.write(
        'userId',
        response['userId'].toString(),
      );
      await SecureStorageHelper.write(
        'firstName',
        response['fullName'],
      );
      await SecureStorageHelper.write(
        'mobileNo',
        response['mobileNo'],
      );
      await SecureStorageHelper.write(
        'ledgerStart',
        response['ledgerStart'] ?? '',
      );
      await SecureStorageHelper.write(
        'ledgerEnd',
        response['ledgerEnd'] ?? '',
      );
      await SecureStorageHelper.write(
        'token',
        response['token'],
      );
      await SecureStorageHelper.write(
        'company',
        selectedCoName.value,
      );

      Get.offAll(
        () => HomeScreen(),
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

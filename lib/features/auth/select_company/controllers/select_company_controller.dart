import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCompanyController extends GetxController {
  var isLoading = false.obs;
  final selectCompanyFormKey = GlobalKey<FormState>();

  var selectedCompany = ''.obs;
  var selectedYear = ''.obs;
}

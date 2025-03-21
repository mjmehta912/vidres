import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/features/user_settings/users/models/user_dm.dart';
import 'package:vidres_app/features/user_settings/users/repos/users_repo.dart';
import 'package:vidres_app/utils/dialogs/app_dialogs.dart';

class UsersController extends GetxController {
  var isLoading = false.obs;

  var users = <UserDm>[].obs;
  var filteredUsers = <UserDm>[].obs;
  var searchController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    await getUsers();
  }

  Future<void> getUsers() async {
    try {
      isLoading.value = true;

      final fetchedUsers = await UsersRepo.getUsers();

      users.assignAll(fetchedUsers);
      filteredUsers.assignAll(fetchedUsers);
    } catch (e) {
      showErrorSnackbar(
        'Error',
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void filterUsers(String query) {
    filteredUsers.assignAll(
      users.where(
        (user) {
          return user.userName.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
              user.fullName.toLowerCase().contains(
                    query.toLowerCase(),
                  );
        },
      ).toList(),
    );
  }
}

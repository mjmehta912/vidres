import 'package:get/get.dart';
import 'package:vidres_app/features/home/controllers/home_controller.dart';
import 'package:vidres_app/features/user_settings/user_rights/models/user_access_dm.dart';
import 'package:vidres_app/features/user_settings/user_rights/repos/user_access_repo.dart';
import 'package:vidres_app/features/user_settings/users/controllers/users_controller.dart';
import 'package:vidres_app/utils/dialogs/app_dialogs.dart';

class UserAccessController extends GetxController {
  var isLoading = false.obs;

  var menuAccess = <MenuAccessDm>[].obs;

  Future<void> getUserAccess({
    required int userId,
  }) async {
    try {
      isLoading.value = true;

      final fetchedUserAccess = await UserAccessRepo.getUserAccess(
        userId: userId,
      );

      menuAccess.assignAll(fetchedUserAccess.menuAccess);
    } catch (e) {
      showErrorSnackbar(
        'Error',
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  final UsersController usersController = Get.find<UsersController>();

  Future<void> setAppAccess({
    required int userId,
    required bool appAccess,
  }) async {
    isLoading.value = true;

    try {
      var response = await UserAccessRepo.setAppAccess(
        userId: userId,
        appAccess: appAccess,
      );

      if (response != null && response.containsKey('message')) {
        String message = response['message'];
        await usersController.getUsers();
        showSuccessSnackbar(
          'Success',
          message,
        );
      }
    } catch (e) {
      showErrorSnackbar(
        'Error',
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  final HomeController homeController = Get.find<HomeController>();

  Future<void> setMenuAccess({
    required int userId,
    required int menuId,
    required bool menuAccess,
  }) async {
    isLoading.value = true;

    try {
      var response = await UserAccessRepo.setMenuAccess(
        userId: userId,
        menuId: menuId,
        menuAccess: menuAccess,
      );

      if (response != null && response.containsKey('message')) {
        String message = response['message'];

        getUserAccess(
          userId: userId,
        );

        homeController.getUserAccess();

        showSuccessSnackbar(
          'Success',
          message,
        );
      }
    } catch (e) {
      showErrorSnackbar(
        'Error',
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}

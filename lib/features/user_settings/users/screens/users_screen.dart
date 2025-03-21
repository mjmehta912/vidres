import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/features/user_settings/users/controllers/users_controller.dart';
import 'package:vidres_app/features/user_settings/users/widgets/users_card.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/constants/color_constants.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';
import 'package:vidres_app/utils/screen_utils/app_spacings.dart';
import 'package:vidres_app/utils/widgets/app_appbar.dart';
import 'package:vidres_app/utils/widgets/app_loading_overlay.dart';
import 'package:vidres_app/utils/widgets/app_text_form_field.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({
    super.key,
  });

  final UsersController _controller = Get.put(
    UsersController(),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            backgroundColor: kColorWhite,
            appBar: AppAppbar(
              title: 'Users',
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: kColorTextPrimary,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            body: Padding(
              padding: AppPaddings.p10,
              child: Column(
                children: [
                  AppTextFormField(
                    controller: _controller.searchController,
                    hintText: 'Search User',
                    onChanged: (value) {
                      _controller.filterUsers(value);
                    },
                  ),
                  AppSpaces.v10,
                  Obx(
                    () {
                      if (_controller.filteredUsers.isEmpty &&
                          !_controller.isLoading.value) {
                        return Expanded(
                          child: Center(
                            child: Text(
                              'No users found.',
                              style: TextStyles.kRegularPoppins(
                                fontSize: FontSizes.k18FontSize,
                                color: kColorTextPrimary,
                              ),
                            ),
                          ),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _controller.filteredUsers.length,
                          itemBuilder: (context, index) {
                            final user = _controller.filteredUsers[index];
                            return UsersCard(
                              user: user,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(
          () => AppLoadingOverlay(
            isLoading: _controller.isLoading.value,
          ),
        ),
      ],
    );
  }
}

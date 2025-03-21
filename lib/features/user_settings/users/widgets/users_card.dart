import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/features/user_settings/user_rights/screens/user_access_screen.dart';
import 'package:vidres_app/features/user_settings/users/models/user_dm.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/constants/color_constants.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';
import 'package:vidres_app/utils/screen_utils/app_spacings.dart';

class UsersCard extends StatelessWidget {
  const UsersCard({
    super.key,
    required this.user,
  });

  final UserDm user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => UserAccessScreen(
            userId: user.userId,
            fullName: user.fullName,
            appAccess: user.appAccess,
          ),
        );
      },
      child: Column(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: kColorBackground,
            child: Padding(
              padding: AppPaddings.p10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: TextStyles.kMediumPoppins(
                          fontSize: FontSizes.k18FontSize,
                        ),
                      ),
                      Text(
                        'App Access : ${user.appAccess ? 'Enabled' : 'Disabled'}',
                        style: TextStyles.kLightPoppins(
                          fontSize: FontSizes.k14FontSize,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 20,
                    color: kColorTextPrimary,
                  ),
                ],
              ),
            ),
          ),
          AppSpaces.v6,
        ],
      ),
    );
  }
}

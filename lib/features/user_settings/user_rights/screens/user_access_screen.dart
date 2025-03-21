import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/features/user_settings/user_rights/controllers/user_access_controller.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/constants/color_constants.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';
import 'package:vidres_app/utils/screen_utils/app_spacings.dart';
import 'package:vidres_app/utils/widgets/app_appbar.dart';
import 'package:vidres_app/utils/widgets/app_loading_overlay.dart';

// ignore: must_be_immutable
class UserAccessScreen extends StatefulWidget {
  UserAccessScreen({
    super.key,
    required this.userId,
    required this.fullName,
    required this.appAccess,
  });

  final int userId;
  final String fullName;
  bool appAccess;

  @override
  State<UserAccessScreen> createState() => _UserAccessScreenState();
}

class _UserAccessScreenState extends State<UserAccessScreen> {
  final UserAccessController _controller = Get.put(
    UserAccessController(),
  );

  @override
  void initState() {
    super.initState();
    _controller.getUserAccess(
      userId: widget.userId,
    );
  }

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
              title: widget.fullName,
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
                                'App Access',
                                style: TextStyles.kRegularPoppins(
                                  color: kColorTextPrimary,
                                  fontSize: FontSizes.k18FontSize,
                                ),
                              ),
                              Text(
                                'Allow user to access app',
                                style: TextStyles.kLightPoppins(
                                  color: kColorTextPrimary,
                                  fontSize: FontSizes.k14FontSize,
                                ),
                              )
                            ],
                          ),
                          Switch(
                            value: widget.appAccess,
                            activeColor: kColorWhite,
                            inactiveThumbColor: kColorWhite,
                            inactiveTrackColor: kColorGrey,
                            activeTrackColor: kColorTextPrimary,
                            onChanged: (value) async {
                              await _controller.setAppAccess(
                                userId: widget.userId,
                                appAccess: value,
                              );
                              setState(
                                () {
                                  widget.appAccess = value;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpaces.v20,
                  Visibility(
                    visible: widget.appAccess,
                    child: Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _controller.menuAccess.length,
                        itemBuilder: (context, index) {
                          final menuAccess = _controller.menuAccess[index];

                          return Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.all(0),
                                leading: Text(
                                  menuAccess.menuName,
                                  style: TextStyles.kMediumPoppins(
                                    fontSize: FontSizes.k18FontSize,
                                    color: kColorTextPrimary,
                                  ),
                                ),
                                trailing: Switch(
                                  value: menuAccess.access,
                                  activeColor: kColorWhite,
                                  inactiveThumbColor: kColorWhite,
                                  inactiveTrackColor: kColorGrey,
                                  activeTrackColor: kColorTextPrimary,
                                  onChanged: (value) async {
                                    await _controller.setMenuAccess(
                                      userId: widget.userId,
                                      menuId: menuAccess.menuId,
                                      menuAccess: value,
                                    );
                                    setState(
                                      () {
                                        menuAccess.access = value;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
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

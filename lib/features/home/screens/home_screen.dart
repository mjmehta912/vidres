import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vidres_app/features/auth/reset_password/screens/reset_password_screen.dart';
import 'package:vidres_app/features/godown_transfer/screens/godown_transfer_screen.dart';
import 'package:vidres_app/features/issue_godown/screens/issue_godown_screen.dart';
import 'package:vidres_app/features/user_settings/users/screens/users_screen.dart';
import 'package:vidres_app/features/wip_entry/screens/wip_entry_screen.dart';
import 'package:vidres_app/services/version_info_service.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/utils/constants/color_constants.dart';
import 'package:vidres_app/features/home/controllers/home_controller.dart';
import 'package:vidres_app/features/home/widgets/home_card.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/constants/image_constants.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  final HomeController _controller = Get.put(
    HomeController(),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: kColorBackground,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: AppPaddings.p14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        _controller.company.value,
                        style: TextStyles.kRegularPoppins(),
                      ),
                    ),
                    Row(),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: kColorWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: AppPaddings.p14,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => _controller.menuAccess
                                          .firstWhere((menuAcc) =>
                                              menuAcc.menuName == 'Issue Entry')
                                          .access
                                      ? HomeCard(
                                          primaryColor: kColorCard4Primary,
                                          secondaryColor: kColorCard4Secondary,
                                          title: 'Issue Entry',
                                          subTitle:
                                              'Enter item issue for production.',
                                          onTap: () {
                                            _controller.scanAndValidateIssue();
                                          },
                                          image: kImageIssueEntry,
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                Obx(
                                  () => _controller.menuAccess
                                          .firstWhere((menuAcc) =>
                                              menuAcc.menuName == 'WIP Entry')
                                          .access
                                      ? HomeCard(
                                          primaryColor: kColorCard3Primary,
                                          secondaryColor: kColorCard3Secondary,
                                          title: 'WIP Entry',
                                          subTitle:
                                              'Mark items as work in progress.',
                                          onTap: () {
                                            Get.to(
                                              () => WipEntryScreen(),
                                            );
                                          },
                                          image: kImageWipEntry,
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                Obx(
                                  () => _controller.menuAccess
                                          .firstWhere((menuAcc) =>
                                              menuAcc.menuName ==
                                              'Godown Transfer')
                                          .access
                                      ? HomeCard(
                                          primaryColor: kColorCard5Primary,
                                          secondaryColor: kColorCard5Secondary,
                                          title: 'Godown Transfer',
                                          subTitle:
                                              'Transfer items between godowns.',
                                          image: kImageGodownTransfer,
                                          onTap: () {
                                            Get.to(
                                              () => GodownTransferScreen(),
                                            );
                                          },
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                Obx(
                                  () => _controller.menuAccess
                                          .firstWhere((menuAcc) =>
                                              menuAcc.menuName ==
                                              'Issue Godown')
                                          .access
                                      ? HomeCard(
                                          primaryColor: kColorCard7Primary,
                                          secondaryColor: kColorCard7Secondary,
                                          title: 'Issue Godown',
                                          subTitle:
                                              'Select a godown for issue entry.',
                                          onTap: () {
                                            Get.to(
                                              () => IssueGodownScreen(
                                                mobileNo:
                                                    _controller.mobileNo.value,
                                              ),
                                            );
                                          },
                                          image: kImageIssueGodown,
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                Obx(
                                  () => _controller.menuAccess
                                          .firstWhere((menuAcc) =>
                                              menuAcc.menuName ==
                                              'User Setting')
                                          .access
                                      ? HomeCard(
                                          primaryColor: kColorCard6Primary,
                                          secondaryColor: kColorCard6Secondary,
                                          title: 'User Settings',
                                          subTitle: 'Adjust user preferences.',
                                          onTap: () {
                                            Get.to(
                                              () => UsersScreen(),
                                            );
                                          },
                                          image: kImageUserSettings,
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                HomeCard(
                                  primaryColor: kColorCard1Primary,
                                  secondaryColor: kColorCard1Secondary,
                                  title: 'Reset Password',
                                  subTitle: 'Reset password of your account.',
                                  onTap: () {
                                    Get.to(
                                      () => ResetPasswordScreen(
                                        mobileNo: _controller.mobileNo.value,
                                      ),
                                    );
                                  },
                                  image: kImageResetPassword,
                                ),
                                HomeCard(
                                  primaryColor: kColorCard2Primary,
                                  secondaryColor: kColorCard2Secondary,
                                  title: 'Logout',
                                  subTitle: 'Log out of your account.',
                                  onTap: () {
                                    _controller.logoutUser();
                                  },
                                  image: kImageLogout,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyles.kRegularPoppins(
                            fontSize: FontSizes.k14FontSize,
                            color: kColorBlack,
                          ),
                          children: [
                            TextSpan(
                              text: "Developed by ",
                            ),
                            TextSpan(
                              text: "Jinee Infotech",
                              style: TextStyles.kRegularPoppins(
                                fontSize: FontSizes.k14FontSize,
                                color: Colors.deepPurple,
                              ).copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.deepPurple,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  final Uri url = Uri.parse(
                                    "https://jinee.in/Default.aspx",
                                  );
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(
                                      url,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  }
                                },
                            ),
                            TextSpan(text: "  |  "),
                            WidgetSpan(
                              child: FutureBuilder<String>(
                                future: VersionService.getVersion(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text(
                                      "v...",
                                      style: TextStyles.kRegularPoppins(
                                        fontSize: FontSizes.k14FontSize,
                                        color: kColorBlack,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(
                                      "vError",
                                      style: TextStyles.kRegularPoppins(
                                        fontSize: FontSizes.k14FontSize,
                                        color: kColorRed,
                                      ),
                                    );
                                  } else {
                                    return Text(
                                      "v${snapshot.data}",
                                      style: TextStyles.kRegularPoppins(
                                        fontSize: FontSizes.k14FontSize,
                                        color: kColorBlack,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

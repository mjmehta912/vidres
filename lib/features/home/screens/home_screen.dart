import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/features/godown_transfer/screens/godown_transfer_screen.dart';
import 'package:vidres_app/features/wip_entry/screens/wip_entry_screen.dart';
import 'package:vidres_app/utils/constants/color_constants.dart';
import 'package:vidres_app/features/home/controllers/home_controller.dart';
import 'package:vidres_app/features/home/widgets/home_card.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/constants/image_constants.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';
import 'package:vidres_app/utils/screen_utils/app_spacings.dart';

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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: AppPaddings.p14,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HomeCard(
                            primaryColor: kColorCard5Primary,
                            secondaryColor: kColorCard5Secondary,
                            title: 'Godown Transfer',
                            subTitle: 'Transfer items between godowns.',
                            image: kImageGodownTransfer,
                            onTap: () {
                              Get.to(
                                () => GodownTransferScreen(),
                              );
                            },
                          ),
                          AppSpaces.v8,
                          HomeCard(
                            primaryColor: kColorCard3Primary,
                            secondaryColor: kColorCard3Secondary,
                            title: 'WIP Entry',
                            subTitle: 'Mark items as work in progress.',
                            onTap: () {
                              Get.to(
                                () => WipEntryScreen(),
                              );
                            },
                            image: kImageWipEntry,
                          ),
                          AppSpaces.v8,
                          HomeCard(
                            primaryColor: kColorCard4Primary,
                            secondaryColor: kColorCard4Secondary,
                            title: 'Issue Entry',
                            subTitle: 'Enter item issue for production.',
                            onTap: () {},
                            image: kImageIssueEntry,
                          ),
                          AppSpaces.v8,
                          HomeCard(
                            primaryColor: kColorCard6Primary,
                            secondaryColor: kColorCard6Secondary,
                            title: 'App Settings',
                            subTitle: 'Adjust app preferences.',
                            onTap: () {},
                            image: kImageAppSettings,
                          ),
                          AppSpaces.v8,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/constants/color_constants.dart';
import 'package:vidres_app/features/auth/login/screens/login_screen.dart';
import 'package:vidres_app/features/home/widgets/home_card.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';
import 'package:vidres_app/utils/screen_utils/app_spacings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  // final HomeController _controller = Get.put(
  //   HomeController(),
  // );

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
                    Text(
                      'Ceramic Inventory',
                      style: TextStyles.kRegularPoppins(
                        fontSize: FontSizes.k24FontSize,
                      ),
                    ),
                    AppSpaces.v20,
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
                            onTap: () {},
                          ),
                          AppSpaces.v6,
                          HomeCard(
                            primaryColor: kColorCard1Primary,
                            secondaryColor: kColorCard1Secondary,
                            title: 'WIP Entry',
                            subTitle: 'Mark items as work in progress.',
                            onTap: () {},
                          ),
                          AppSpaces.v6,
                          HomeCard(
                            primaryColor: kColorCard3Primary,
                            secondaryColor: kColorCard3Secondary,
                            title: 'Issue Entry',
                            subTitle: 'Enter item issues for production.',
                            onTap: () {},
                          ),
                          AppSpaces.v6,
                          HomeCard(
                            primaryColor: kColorCard4Primary,
                            secondaryColor: kColorCard4Secondary,
                            title: 'Selling Price',
                            subTitle: 'Receive a price estimate.',
                            onTap: () {},
                          ),
                          AppSpaces.v6,
                          HomeCard(
                            primaryColor: kColorCard6Primary,
                            secondaryColor: kColorCard6Secondary,
                            title: 'App Settings',
                            subTitle: 'Adjust app preferences.',
                            onTap: () {},
                          ),
                          AppSpaces.v6,
                          HomeCard(
                            primaryColor: kColorCard2Primary,
                            secondaryColor: kColorCard2Secondary,
                            title: 'Logout',
                            subTitle: 'Log out of your account.',
                            onTap: () {
                              Get.offAll(
                                () => LoginScreen(),
                              );
                            },
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidres_app/utils/constants/color_constants.dart';
import 'package:vidres_app/features/auth/login/screens/login_screen.dart';
import 'package:vidres_app/features/home/screens/home_screen.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/helpers/secure_storage_helper.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () async {
        String? token = await SecureStorageHelper.read(
          'token',
        );

        Future.delayed(
          const Duration(
            seconds: 1,
          ),
          () {
            if (token != null && token.isNotEmpty) {
              Get.offAll(
                () => HomeScreen(),
              );
            } else {
              Get.offAll(
                () => LoginScreen(),
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      body: Center(
        child: Padding(
          padding: AppPaddings.ph10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vidres',
                style: TextStyles.kBoldPoppins(
                  fontSize: FontSizes.k30FontSize,
                ),
              ),
              Text(
                'Ceramic Inventory',
                style: TextStyles.kRegularPoppins(
                  fontSize: FontSizes.k24FontSize,
                ),
              ),
              Row(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';
import 'package:vidres_app/utils/screen_utils/app_spacings.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.primaryColor,
    required this.secondaryColor,
    required this.title,
    required this.subTitle,
    required this.onTap,
    required this.image,
  });

  final Color primaryColor;
  final Color secondaryColor;
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              Card(
                elevation: 5,
                color: primaryColor,
                child: Padding(
                  padding: AppPaddings.p10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyles.kSemiBoldPoppins(),
                          ),
                          AppSpaces.v10,
                          Text(
                            subTitle,
                            style: TextStyles.kRegularPoppins(
                              fontSize: FontSizes.k14FontSize,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 12.5,
                        backgroundColor: secondaryColor,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 10,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 60,
                top: 0,
                bottom: 0,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
        AppSpaces.v8,
      ],
    );
  }
}

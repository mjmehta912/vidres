import 'package:flutter/material.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.primaryColor,
    required this.secondaryColor,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  final Color primaryColor;
  final Color secondaryColor;
  final String title;
  final String subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2.5,
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
                    style: TextStyles.kSemiBoldPoppins().copyWith(
                      height: 1.25,
                    ),
                  ),
                  Text(
                    subTitle,
                    style: TextStyles.kRegularPoppins(
                      fontSize: FontSizes.k16FontSize,
                    ).copyWith(
                      height: 1.25,
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
    );
  }
}

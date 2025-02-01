import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:vidres_app/constants/color_constants.dart';
import 'package:vidres_app/styles/font_sizes.dart';
import 'package:vidres_app/styles/text_styles.dart';
import 'package:vidres_app/utils/extensions/app_size_extensions.dart';
import 'package:vidres_app/utils/screen_utils/app_paddings.dart';

class AppDropdown extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.items,
    this.selectedItem,
    required this.hintText,
    this.searchHintText,
    this.fillColor,
    this.showSearchBox,
    required this.onChanged,
    this.validatorText,
    this.enabled,
  });

  final List<String> items;
  final String? selectedItem;
  final String hintText;
  final String? searchHintText;
  final Color? fillColor;
  final bool? showSearchBox;
  final ValueChanged<String?>? onChanged;
  final String? validatorText;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      selectedItem: selectedItem,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorText;
        }
        return null;
      },
      items: (filter, infiniteScrollProps) => items,
      enabled: enabled ?? true,
      decoratorProps: DropDownDecoratorProps(
        baseStyle: TextStyles.kRegularPoppins(
          fontSize: FontSizes.k18FontSize,
          color: kColorTextPrimary,
        ).copyWith(
          height: 1,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyles.kRegularPoppins(
            fontSize: FontSizes.k16FontSize,
            color: kColorGrey,
          ),
          errorStyle: TextStyles.kRegularPoppins(
            fontSize: FontSizes.k16FontSize,
            color: kColorRed,
          ),
          border: outlineInputBorder(
            borderColor: kColorTextPrimary,
            borderWidth: 1,
          ),
          focusedBorder: outlineInputBorder(
            borderColor: kColorTextPrimary,
            borderWidth: 2,
          ),
          enabledBorder: outlineInputBorder(
            borderColor: kColorTextPrimary,
            borderWidth: 1,
          ),
          errorBorder: outlineInputBorder(
            borderColor: kColorRed,
            borderWidth: 2,
          ),
          disabledBorder: outlineInputBorder(
            borderColor: kColorTextPrimary,
            borderWidth: 1,
          ),
          contentPadding: AppPaddings.combined(
            horizontal: 16.appWidth,
            vertical: 8.appHeight,
          ),
          filled: true,
          fillColor: fillColor ?? kColorWhite,
          suffixIconColor: kColorTextPrimary,
        ),
      ),
      popupProps: PopupProps.menu(
        fit: FlexFit.loose,
        constraints: BoxConstraints(
          maxHeight: 300,
        ),
        menuProps: MenuProps(
          backgroundColor: kColorWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        itemBuilder: (context, item, isDisabled, isSelected) => Padding(
          padding: AppPaddings.p10,
          child: Text(
            item,
            style: TextStyles.kRegularPoppins(
              color: kColorTextPrimary,
              fontSize: FontSizes.k16FontSize,
            ).copyWith(
              height: 1.25,
            ),
          ),
        ),
        showSearchBox: showSearchBox ?? true,
        searchFieldProps: TextFieldProps(
          style: TextStyles.kRegularPoppins(
            fontSize: FontSizes.k16FontSize,
            color: kColorTextPrimary,
          ),
          cursorColor: kColorTextPrimary,
          cursorHeight: 20,
          decoration: InputDecoration(
            hintText: searchHintText ?? 'Search',
            hintStyle: TextStyles.kRegularPoppins(
              fontSize: FontSizes.k16FontSize,
              color: kColorGrey,
            ),
            errorStyle: TextStyles.kRegularPoppins(
              fontSize: FontSizes.k16FontSize,
              color: kColorRed,
            ),
            border: outlineInputBorder(
              borderColor: kColorTextPrimary,
              borderWidth: 1,
            ),
            focusedBorder: outlineInputBorder(
              borderColor: kColorTextPrimary,
              borderWidth: 2,
            ),
            enabledBorder: outlineInputBorder(
              borderColor: kColorTextPrimary,
              borderWidth: 1,
            ),
            errorBorder: outlineInputBorder(
              borderColor: kColorRed,
              borderWidth: 2,
            ),
            disabledBorder: outlineInputBorder(
              borderColor: kColorTextPrimary,
              borderWidth: 1,
            ),
            contentPadding: AppPaddings.combined(
              horizontal: 16.appWidth,
              vertical: 8.appHeight,
            ),
            filled: true,
            fillColor: fillColor ?? kColorWhite,
            suffixIconColor: kColorTextPrimary,
          ),
        ),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder({
    required Color borderColor,
    required double borderWidth,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: borderColor,
        width: borderWidth,
      ),
    );
  }
}

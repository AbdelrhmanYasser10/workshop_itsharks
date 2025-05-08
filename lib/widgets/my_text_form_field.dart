import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utlis/app_colors.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  const MyTextFormField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.kPrimaryColor,
      decoration: InputDecoration(
        fillColor: AppColors.kTextFieldColor,
        filled: true,
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(
          fontSize: 14.0,
          color: AppColors.kIconColor,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.kIconColor,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.kTextFieldBorderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.kTextFieldBorderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.kPrimaryColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.kTextFieldBorderColor,
          ),
        ),
      ),
      style: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
          color: Colors.black
      ),
    );
  }
}

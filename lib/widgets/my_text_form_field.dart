import 'package:e_commerce_platzi/view_model/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utlis/app_colors.dart';

//returntype functionname (parameters)


class MyTextFormField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String?Function(String?) validatorFunction;
  final bool isPassword;
  final void Function(String?)? onChange;
  final bool enable;
  const MyTextFormField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    required this.validatorFunction,
    this.onChange,
    this.enable = true,
    this.isPassword = false,
  });

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {

  late bool isSecure = widget.isPassword;


  @override
  Widget build(BuildContext context) {
    var isDarkMood = ThemeCubit.get(context).isDark;
    return TextFormField(
      enabled: widget.enable,
      onChanged: widget.onChange,
      obscureText: isSecure,
      controller: widget.controller,
      validator: widget.validatorFunction,
      cursorColor: AppColors.kPrimaryColor,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword ?IconButton(
          onPressed: (){
          setState(() {
            isSecure = !isSecure;
            print("isSecure = $isSecure");
          });
        }, icon: Icon(
          isSecure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        ),
        ) :null,
        fillColor: isDarkMood ?Colors.black:
        AppColors.kTextFieldColor,
        filled: true,
        hintText: widget.hintText,
        hintStyle: GoogleFonts.montserrat(
          fontSize: 14.0,
          color:isDarkMood?Colors.grey: AppColors.kIconColor,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          widget.prefixIcon,
          color:isDarkMood?Colors.white: AppColors.kIconColor,
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
          color: isDarkMood ?Colors.white :Colors.black
      ),
    );
  }
}

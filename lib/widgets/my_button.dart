import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utlis/app_colors.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function() function;
  const MyButton({
    super.key,
    required this.text,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        overlayColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        backgroundColor: AppColors.kPrimaryColor,
        minimumSize: Size(double.infinity, 55),
        textStyle: GoogleFonts.montserrat(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),

      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

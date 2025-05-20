import 'package:flutter/material.dart';

import 'app_colors.dart';


class Palette {
  static  MaterialColor kToDark =  MaterialColor(
    0xffffffff, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50:  AppColors.kPrimaryColor,//10%
      100:  AppColors.kPrimaryColor,//20%
      200: AppColors.kPrimaryColor,//30%
      300:  AppColors.kPrimaryColor,//40%
      400:  AppColors.kPrimaryColor,//50%
      500:  AppColors.kPrimaryColor,//60%
      600:  AppColors.kPrimaryColor,//70%
      700:  AppColors.kPrimaryColor,//80%
      800:  AppColors.kPrimaryColor,//90%
      900: AppColors.kPrimaryColor,//100%
    },
  );
}
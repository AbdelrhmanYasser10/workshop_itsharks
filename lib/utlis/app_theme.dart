import 'package:e_commerce_platzi/utlis/swatch_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

abstract class AppTheme{

  static ThemeData  lightTheme = ThemeData(
    cardColor: Colors.white,
    scaffoldBackgroundColor: AppColors.kBgLightColor,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.kBgLightColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.kBgLightColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: AppColors.kBgLightColor,
      elevation: 0,
      surfaceTintColor: AppColors.kBgLightColor,
      titleTextStyle: AppTextStyles.font24BlackBold,
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.kBgLightColor,
        selectedItemColor: AppColors.kPrimaryColor,
        unselectedItemColor: Colors.grey,
        elevation: 0.0,
        selectedIconTheme:  IconThemeData(
          color: AppColors.kPrimaryColor,
        ),
        unselectedLabelStyle: AppTextStyles.font16BlackSemiBold.copyWith(
          color: Colors.grey,
          fontSize: 14,
        ),
        selectedLabelStyle: AppTextStyles.font16BlackBold.copyWith(
          color: AppColors.kPrimaryColor,
          fontSize: 14,
        )
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.font32BlackBold,
      displayMedium: AppTextStyles.font24BlackBold,
      displaySmall: AppTextStyles.font18BlackBold,
      headlineLarge: AppTextStyles.font24BlackSemiBold,
      headlineMedium: AppTextStyles.font18BlackSemiBold,
      headlineSmall: AppTextStyles.font16BlackSemiBold,
      bodyLarge: AppTextStyles.font16BlackBold,
      bodyMedium: AppTextStyles.font16BlackSemiBold,
      bodySmall: AppTextStyles.font16BlackRegular,

    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        textStyle: AppTextStyles.font18WhiteBold,
        minimumSize: const Size(double.infinity, 55),
      ),
    ),
    primaryColor: AppColors.kPrimaryColor,
    primarySwatch: Palette.kToDark,

    useMaterial3: true,
  );

  static ThemeData  darkTheme = ThemeData(
    cardColor: Colors.black,
    scaffoldBackgroundColor: AppColors.kBgDarkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kBgDarkColor,
      elevation: 0,
      surfaceTintColor: AppColors.kBgDarkColor,
      titleTextStyle: AppTextStyles.font24WhiteBold,
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.kBgDarkColor,
        selectedItemColor: AppColors.kPrimaryColor,
        unselectedItemColor: Colors.blueGrey,
        elevation: 0.0,
        selectedIconTheme: IconThemeData(
          color: AppColors.kPrimaryColor,
        ),
        unselectedLabelStyle: AppTextStyles.font16BlackSemiBold.copyWith(
          color: Colors.grey,
          fontSize: 14,
        ),
        selectedLabelStyle: AppTextStyles.font16BlackBold.copyWith(
          color: AppColors.kPrimaryColor,
          fontSize: 14,
        )
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.font32WhiteBold,
      displayMedium: AppTextStyles.font24WhiteBold,
      displaySmall: AppTextStyles.font18WhiteBold,
      headlineLarge: AppTextStyles.font24WhiteSemiBold,
      headlineMedium: AppTextStyles.font18WhiteSemiBold,
      headlineSmall: AppTextStyles.font16WhiteSemiBold,
      bodyLarge: AppTextStyles.font16WhiteBold,
      bodyMedium: AppTextStyles.font16WhiteSemiBold,
      bodySmall: AppTextStyles.font16WhiteRegular,

    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kBgLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        textStyle: AppTextStyles.font18WhiteBold,
        minimumSize: const Size(double.infinity, 55),
      ),
    ),
    primaryColor: AppColors.kPrimaryColor,
    primarySwatch: Palette.kToDark,
    useMaterial3: true,
  );
}

import 'package:e_commerce_platzi/utlis/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/categories_screen/categories_screen.dart';
import '../view/home_screen/home_screen.dart';
import '../view/login_screen/login_screen.dart';
import '../view/main_layout/main_layout.dart';
import '../view/onboarding_screen/onboarding_screen.dart';
import '../view/register_screen/register_screen.dart';
import '../view/splash_screen/splash_screen.dart';

Route<dynamic>?onGenerate(RouteSettings setting){
  switch(setting.name){
    case AppRouter.SplashScreen:
      return MaterialPageRoute(builder: (_)=>SplashScreen());
    case AppRouter.OnBoardingScreen:
      return MaterialPageRoute(builder: (_)=>OnBoardingScreen());
    case AppRouter.LoginScreen:
      return MaterialPageRoute(builder: (_)=>LoginScreen());
    case AppRouter.RegisterScreen:
      return MaterialPageRoute(builder: (_)=>RegisterScreen());
    case AppRouter.HomeScreen:
      return MaterialPageRoute(builder: (_)=>HomeScreen());
    case AppRouter.MainLayout:
      return MaterialPageRoute(builder: (_)=>MainLayout());
    case AppRouter.CategoriesScreen:
      return MaterialPageRoute(builder: (_)=>CategoriesScreen());
  }
  return null;
}
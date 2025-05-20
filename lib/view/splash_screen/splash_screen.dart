
import 'package:e_commerce_platzi/view/main_layout/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:splash_master/core/source.dart';
import 'package:splash_master/core/splash_master.dart';
import 'package:splash_master/enums/splash_master_enums.dart';
import 'package:splash_master/splashes/video/video_config.dart';

import '../../services/network/local/cache_helper/cache_helper.dart';
import '../../utlis/routes.dart';
import '../onboarding_screen/onboarding_screen.dart';
import '../register_screen/register_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SharedPreferencesHelper.getData(key: 'onBoarding') ==  null?
        ()=> Navigator.pushReplacementNamed(context, AppRouter.OnBoardingScreen):
        ()=> Navigator.pushReplacementNamed(context, AppRouter.LoginScreen);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SplashMaster.lottie(
          source: AssetSource("assets/image/Animation - 1747734944115.json"),
          backGroundColor: Colors.white,
          nextScreen:  SharedPreferencesHelper.getData(key: 'onBoarding') == null ?
          OnBoardingScreen() :
          SharedPreferencesHelper.getData(key: 'token') == null ?
          RegisterScreen():
          MainLayout(),
        ),
      ),
    );
  }
}
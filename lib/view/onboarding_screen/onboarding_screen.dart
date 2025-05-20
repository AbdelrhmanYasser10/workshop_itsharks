import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../model/on_boarding_model/on_boarding_model.dart';
import '../../services/network/local/cache_helper/cache_helper.dart';
import '../../utlis/app_colors.dart';
import '../../utlis/routes.dart';
import 'onboarding_builder.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  var isLast = false;
  void finishOnBoarding(context, String screen) {
    SharedPreferencesHelper.saveData(key: 'onBoarding', value: isLast);
    Navigator.of(context).pushNamedAndRemoveUntil(screen, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              finishOnBoarding(context, AppRouter.LoginScreen);
            },
            child: Text(
              'Skip',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(

            child: PageView.builder(
              onPageChanged: (int index) {
                if (index == dataOnBoarding.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              itemBuilder: (context, index) {
                return BuilderOnBoarding(
                  onBoardingModel: dataOnBoarding[index],
                );
              },
              itemCount: dataOnBoarding.length,
            ),
          ),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                
                  count: dataOnBoarding.length,
                  axisDirection: Axis.horizontal,
                  effect: SlideEffect(
                    spacing: 8.0,
                    radius: 4.0,
                    dotWidth: 24.0,
                    dotHeight: 16.0,
                    paintStyle: PaintingStyle.stroke,
                    strokeWidth: 1.5,
                    dotColor: Colors.grey,
                    activeDotColor: AppColors.kPrimaryColor,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRouter.LoginScreen,
                      (route) => false,
                    );
                  },
                  child: Text(
                    'Next',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
                Visibility(
                  visible: isLast,
                  child: TextButton(
                    onPressed: () {
                      finishOnBoarding(context, AppRouter.GetStartedScreen);
                    },
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.montserrat(
                        color: AppColors.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

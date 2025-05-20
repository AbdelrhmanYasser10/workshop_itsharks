import 'package:e_commerce_platzi/view_model/theme_cubit/theme_cubit.dart';
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
  int currIdx = 0;

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
                color:ThemeCubit.get(context).isDark ?  Colors.white:Colors.black,
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
              controller: pageController,
              onPageChanged: (int index) {
                if (index == dataOnBoarding.length - 1) {
                  setState(() {
                    currIdx = index;
                    isLast = true;
                  });
                } else {
                  setState(() {
                    currIdx = index;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (currIdx > 0 && !isLast)? TextButton(
                onPressed: () {
                  pageController.previousPage(
                      duration: Duration(milliseconds: 900),
                      curve: Curves.decelerate);
                },
                child: Text(
                  'Prev',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              ):const SizedBox(),
              const Spacer(),

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
              const Spacer(),

              TextButton(
                onPressed: () {
                  if(isLast) {
                    SharedPreferencesHelper.saveData(key: 'onBoarding', value: isLast);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRouter.LoginScreen,
                          (route) => false,
                    );
                  }
                  else {
                    pageController.nextPage(
                        duration: Duration(milliseconds: 900),
                        curve: Curves.decelerate);
                  }
                },
                child: Text(
                  isLast ? 'Get Started':'Next',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

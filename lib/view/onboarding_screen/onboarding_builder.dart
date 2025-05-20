import 'package:flutter/cupertino.dart';

import '../../model/on_boarding_model/on_boarding_model.dart';


class BuilderOnBoarding extends StatelessWidget {
  final OnBoardingModel onBoardingModel ;
  const BuilderOnBoarding({super.key,required this.onBoardingModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Image.asset(onBoardingModel.image),
        Text(onBoardingModel.dis),

      ],
    );
  }
}
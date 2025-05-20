import 'package:flutter/material.dart';

import '../../model/on_boarding_model/on_boarding_model.dart';


class BuilderOnBoarding extends StatelessWidget {
  final OnBoardingModel onBoardingModel ;
  const BuilderOnBoarding({super.key,required this.onBoardingModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Image.asset(onBoardingModel.image),
        Text(onBoardingModel.title,style: Theme.of(context).textTheme.displayMedium,),
        Text(onBoardingModel.dis,style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.center,),

      ],
    );
  }
}
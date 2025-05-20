class OnBoardingModel{
  String image;
  String dis;

  OnBoardingModel({ required this.image,required this.dis});

}

List<OnBoardingModel> dataOnBoarding = [
  OnBoardingModel(image: 'assets/image/photo2', dis:'Choose Products\nAmet minim mollit non deserunt ullamco est\n sit aliqua dolor do amet sint. Velit officia\n consequat duis enim velit mollit.' ),
  OnBoardingModel(image: 'assets/image/photo3',dis: 'Make Payment\nAmet minim mollit non deserunt ullamco est\n sit aliqua dolor do amet sint. Velit officia\n consequat duis enim velit mollit.'),
  OnBoardingModel(image: 'assets/image/photo4', dis: 'Get Your Order\nAmet minim mollit non deserunt ullamco est\n sit aliqua dolor do amet sint. Velit officia\n consequat duis enim velit mollit.'),
];
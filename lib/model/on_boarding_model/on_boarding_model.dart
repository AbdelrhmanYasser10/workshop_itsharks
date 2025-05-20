class OnBoardingModel{
  String image;
  String title;
  String dis;

  OnBoardingModel({ required this.image,required this.dis,required this.title});

}

List<OnBoardingModel> dataOnBoarding = [
  OnBoardingModel(image: 'assets/image/fashion shop-rafiki 1.png',title: 'Choose Products', dis:'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.' ),
  OnBoardingModel(image: 'assets/image/Sales consulting-pana 1.png',title: 'Make Payment',dis: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.'),
  OnBoardingModel(image: 'assets/image/Shopping bag-rafiki 1.png',title: 'Get Your Order', dis: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.'),
];
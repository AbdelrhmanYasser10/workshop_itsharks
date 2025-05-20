import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_platzi/model/product_model/product_model.dart';
import 'package:e_commerce_platzi/utlis/app_text_styles.dart';
import 'package:e_commerce_platzi/view_model/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rich_text_view/rich_text_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utlis/app_colors.dart';
import '../../widgets/product_card.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel product;
  const ProductDetails({super.key , required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final CarouselSliderController _pageController = CarouselSliderController();
  int _currentCarouselPage = 0;
  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getProductsFromCategory(categoryId: widget.product.category!.id!);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: ()=>Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
            ),
        ),
        actions: [
          IconButton(onPressed: (){},
              icon: Icon(
                LineIcons.shoppingBag,
              ),
          ),
        ],
      ),
      body:SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                  carouselController: _pageController,
                  options: CarouselOptions(
                      height: 300.0,
                    aspectRatio: 16/9,
                    enableInfiniteScroll: true,
                    enlargeFactor: 0.8,
                    viewportFraction: 1,

                    onPageChanged: (index, reason) {
                      _currentCarouselPage = index;
                      setState(() {

                      });
                    },
                    autoPlay: true,
                  ),
                  items: widget.product.images!.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.network(
                          imageUrl,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  }).toList(),
                ),
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors:[
                          Colors.black54,
                          Colors.transparent
                        ] ,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter
                    )
                  ),
                ),
                Positioned(
                  bottom: 0,
                    left: 0,
                    right: 0,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //{
                      // 0:"url1"
                      // 1:"url2"
                      // }
                      children: widget.product.images!.asMap().entries.map((entry) {
                        print(entry.value); //url
                        print(entry.key); //index
                        return GestureDetector(
                          onTap: () => _pageController.animateToPage(entry.key),
                          child: Container(
                            width: 15,
                            height: 15,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:_currentCarouselPage == entry.key?
                                  AppColors.kPrimaryColor:
                              (Colors.grey).withOpacity(0.4),
                            ),

                          ),
                        );
                      }).toList(),
                    ),

                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title!,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Product Description",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  RichTextView(
                      text:widget.product.description!,
                      maxLines: 3,
                      truncate: true,
                      viewLessText: 'see less',
                      style:Theme.of(context).textTheme.bodySmall ,
                      linkStyle: TextStyle(color:AppColors.kPrimaryColor),
                      supportedTypes: [
                        EmailParser(
                            onTap: (email) => print('${email.value} clicked')),
                        PhoneParser(
                            onTap: (phone) => print('click phone ${phone.value}')),
                        MentionParser(
                            onTap: (mention) => print('${mention.value} clicked')),
                        UrlParser(onTap: (url) => print('visting ${url.value}?')),
                        BoldParser(),
                        HashTagParser(
                            onTap: (hashtag) =>
                                print('is ${hashtag.value} trending?'))
                      ]
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),

                  Row(
                    children: [
                      Text(
                        "Category",
                        style: AppTextStyles.font16BlackBold.copyWith(
                            color: AppColors.kPrimaryColor
                        ),
                      ),
                      SizedBox(width: 10,),

                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(
                          widget.product.category!.image!
                        ),

                      ),
                      SizedBox(width: 5,),
                      Text(
                        widget.product.category!.name!,
                        style: AppTextStyles.font16BlackBold.copyWith(
                            color: AppColors.kPrimaryColor,
                          fontSize: 12
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Price: ${widget.product.price} EGP",
                    style: AppTextStyles.font18BlackBold.copyWith(
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Similar Products",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  BlocConsumer<HomeCubit,HomeState>(
                      listener: (context, state) {

                      },
                      builder: (context, state) {
                        var cubit = HomeCubit.get(context);

                         if(state is GetProductsLoading || cubit.allProductsFromCategory.isEmpty) {
                           return Center(
                             child: CircularProgressIndicator(
                               color: AppColors.kPrimaryColor,
                             ),
                           );
                         }
                         else {
                           return GridView.builder(
                             physics: const NeverScrollableScrollPhysics(),
                             shrinkWrap: true,
                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                               crossAxisCount: 2,
                               mainAxisSpacing: 10,
                               crossAxisSpacing: 10,
                               //w / h
                               childAspectRatio: 1 / 1.6,
                             ),
                             itemBuilder: (context, index) {
                               return ProductCard(product: cubit
                                   .allProductsFromCategory[index]);
                             },
                             itemCount: cubit.allProductsFromCategory.length,
                           );
                         }
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

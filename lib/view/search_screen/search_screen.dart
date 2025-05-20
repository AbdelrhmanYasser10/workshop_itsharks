import 'package:e_commerce_platzi/view_model/home_cubit/home_cubit.dart';
import 'package:e_commerce_platzi/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '../../utlis/app_colors.dart';
import '../../widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              MyTextFormField(
                  hintText: "Product title .....",
                  prefixIcon: LineIcons.search,
                onChange: (keyWord) {
                  HomeCubit.get(context).getProductsFromSearch(keyWord: keyWord!);
                },
                controller: _controller,
                validatorFunction: (value) {

                  },
              ),
              const SizedBox(height: 10.0,),
              Expanded(
                  child:
              BlocConsumer<HomeCubit,HomeState>(
                listener: (context, state) {

                },
                  builder: (context, state) {
                  var cubit = HomeCubit.get(context);
                    if(state is GetProductsFromSearchLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kPrimaryColor,
                        ),
                      );
                    }
                    else{
                        if(cubit.allProductsFromSearch.isEmpty){
                          return Center(
                            child: Text(
                              "${_controller.text} is not found"
                            ),
                          );
                        }
                        return  GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        //w / h
                        childAspectRatio: 1 / 1.6,
                      ),
                      itemBuilder: (context, index) {
                        return ProductCard(product: cubit.allProductsFromSearch[index]);
                      },
                      itemCount: cubit.allProductsFromSearch.length,
                    );
                    }
                  },


              )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:e_commerce_platzi/view_model/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utlis/app_colors.dart';
import '../../widgets/product_card.dart';

class FilteredProducts extends StatelessWidget {
  const FilteredProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit =  HomeCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.kBgColor,
          appBar: AppBar(
            backgroundColor: AppColors.kBgColor,
            surfaceTintColor: AppColors.kBgColor,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu, color: AppColors.kIconColor),
            ),
            title: Image.asset("assets/image/logoipsum-255 1.png"),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  backgroundImage:
                  (cubit.user != null)
                      ? NetworkImage(cubit.user!.avatar!)
                      : null,
                  child:
                  (state is GetProfileLoading || cubit.user == null)
                      ? CircularProgressIndicator(
                    backgroundColor: AppColors.kPrimaryColor,
                  )
                      : null,
                ),
              ),
            ],
          ),
            body: (state is GetProductsLoading || cubit.allProductsFromCategory.isEmpty)
                ? Center(
              child: CircularProgressIndicator(
                color: AppColors.kPrimaryColor,
              ),
            )
                : GridView.builder(
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
                return ProductCard(product: cubit.allProductsFromCategory[index]);
              },
              itemCount: cubit.allProductsFromCategory.length,
            ),
        );
      },
    );
  }
}

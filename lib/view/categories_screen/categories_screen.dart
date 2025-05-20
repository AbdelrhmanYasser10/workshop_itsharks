import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:e_commerce_platzi/utlis/app_functions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utlis/app_colors.dart';
import '../../view_model/home_cubit/home_cubit.dart';
import '../../widgets/cateogry_card.dart';
import '../register_screen/register_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetCategoriesError) {
          showAppSnackBar(
            context,
             "Session Expired",
            'please login again',
            ContentType.failure,
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => RegisterScreen()),
                (route) => false,
          );
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu, color: AppColors.kIconColor),
            ),
            title: Image.asset('assets/image/logoipsum-255 1.png'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  backgroundImage:
                  (cubit.user != null)
                      ? NetworkImage(cubit.user!.avatar!)
                      : null,
                  child:
                  (state is GetCategoriesLoading || cubit.user == null)
                      ? CircularProgressIndicator(
                    backgroundColor: AppColors.kPrimaryColor,
                  )
                      : null,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),

            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: (state is GetCategoriesLoading || cubit.allCategories.isEmpty)?
              Center(
                child: CircularProgressIndicator(
                  color: AppColors.kPrimaryColor,
                ),
              ):
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1/1.6,
                ),
                itemCount: cubit.allCategories.length,
                itemBuilder: (context,index){
                  return CategoriesCard(categories: cubit.allCategories[index]);
                },

              ),
            ),
          ),
        );
      },
    );

  }
}
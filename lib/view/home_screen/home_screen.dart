import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:e_commerce_platzi/view_model/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utlis/app_colors.dart';
import '../../utlis/app_functions.dart';
import '../register_screen/register_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetProfileError) {
          showAppSnackBar(
            context,
            "Session Expired",
            "Please login again",
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
        var cubit = HomeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
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
                    backgroundImage:(cubit.user != null) ?NetworkImage(
                      cubit.user!.avatar!
                    ):null,
                    child: (state is GetProfileLoading || cubit.user == null)?
                  CircularProgressIndicator(
                    backgroundColor: AppColors.kPrimaryColor,
                  ):null,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 90,
                  child:(state is GetCategoriesLoading || cubit.allCategories.isEmpty)
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.kPrimaryColor,
                    ),
                  ): ListView.separated(
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 90,
                          child: Column(
                            children: [
                              Expanded(
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                    cubit.allCategories[index].image!,
                                  ),
                                ),
                              ),
                              Text(
                                cubit.allCategories[index].name!,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 10,);
                      },
                      itemCount: cubit.allCategories.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

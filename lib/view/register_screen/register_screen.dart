import 'dart:io';

import 'package:e_commerce_platzi/view_model/authentication/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utlis/app_colors.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create an account",
              style: GoogleFonts.montserrat(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: Stack(
                children: [
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      var cubit = AuthCubit.get(context);
                      return CircleAvatar(
                        backgroundColor: AppColors.kBgColor,
                        radius: 50,
                        backgroundImage: cubit.image == null ?
                        AssetImage("assets/image/default.jpg"):
                        FileImage(
                          File(
                              cubit.image!.path,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        showBottomSheet(
                          context: context,
                          builder: (context) {
                            var cubit = AuthCubit.get(context);
                            return Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    cubit.getImage("camera");
                                  },
                                  child: Text(
                                      "Pick image from camera"
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    cubit.getImage("gallery");
                                  },
                                  child: Text(
                                      "Pick image from gallery"
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.kPrimaryColor,
                        radius: 15,
                        child: Center(
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            MyTextFormField(hintText: "Email", prefixIcon: Icons.email),
            const SizedBox(height: 20),
            MyTextFormField(hintText: "Username", prefixIcon: Icons.person),
            const SizedBox(height: 20),

            MyTextFormField(hintText: "Password", prefixIcon: Icons.lock),
            const SizedBox(height: 20),

            MyTextFormField(
              hintText: "Confirm Password",
              prefixIcon: Icons.lock,
            ),

            const SizedBox(height: 75),

            MyButton(
              text: "Register",
              function: () {},
            ),
          ],
        ),
      ),
    );
  }
}


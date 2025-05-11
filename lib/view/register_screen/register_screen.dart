import 'dart:io';

import 'package:e_commerce_platzi/view/login_screen/login_screen.dart';
import 'package:e_commerce_platzi/view_model/authentication/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utlis/app_colors.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  late PersistentBottomSheetController controller;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.kBgColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                        listener: (context, state) {
                          if (state is PickImageSuccessfully) {
                            AuthCubit.get(context).cropImage();
                            controller.close();
                          }
                        },
                        builder: (context, state) {
                          var cubit = AuthCubit.get(context);
                          return CircleAvatar(
                            backgroundColor: AppColors.kBgColor,
                            radius: 50,
                            backgroundImage:
                                cubit.croppedImage == null
                                    ? AssetImage("assets/image/default.jpg")
                                    : FileImage(File(cubit.croppedImage!.path)),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            controller = _scaffoldKey.currentState!
                                .showBottomSheet((context) {
                                  var cubit = AuthCubit.get(context);
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          cubit.getImage("camera");
                                        },
                                        child: Text(
                                          "Camera",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          cubit.getImage("gallery");
                                        },
                                        child: Text(
                                          "Gallery",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                });
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
                MyTextFormField(
                  controller: _emailController,
                  hintText: "Email",
                  prefixIcon: Icons.email,
                  validatorFunction: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email cannot be empty";
                    }
                  },
                ),
                const SizedBox(height: 20),
                MyTextFormField(
                  controller: _usernameController,
                  hintText: "Username",
                  prefixIcon: Icons.person,
                  validatorFunction: (p0) {},
                ),
                const SizedBox(height: 20),

                MyTextFormField(
                  controller: _passwordController,
                  hintText: "Password",
                  prefixIcon: Icons.lock,
                  validatorFunction: (p0) {},
                  isPassword: true,
                ),
                const SizedBox(height: 20),

                MyTextFormField(
                  controller: _confirmPasswordController,
                  hintText: "Confirm Password",
                  prefixIcon: Icons.lock,
                  validatorFunction: (p0) {},
                  isPassword: true,
                ),

                const SizedBox(height: 75),

                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is RegisterLoading || state is UploadImageLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kPrimaryColor,
                        ),
                      );
                    }
                    return MyButton(
                      text: "Register",
                      function: () {
                        if (_formKey.currentState!.validate()) {
                          AuthCubit.get(context).register(
                            email: _emailController.text,
                            password: _passwordController.text,
                            username: _usernameController.text,
                          );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    GestureDetector(
                      onTap: ()=>Navigator.pushReplacement(context, 
                      MaterialPageRoute(builder: (_)=>LoginScreen())
                      ),
                      child: Text(
                        "Login",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: AppColors.kPrimaryColor
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

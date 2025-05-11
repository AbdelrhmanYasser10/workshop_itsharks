import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:e_commerce_platzi/view/main_layout/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utlis/app_colors.dart';
import '../../utlis/app_functions.dart';
import '../../view_model/authentication/auth_cubit.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_form_field.dart';
import '../register_screen/register_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Welcome Back!",
                  style: GoogleFonts.montserrat(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 50),
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
                  controller: _passwordController,
                  hintText: "Password",
                  prefixIcon: Icons.lock,
                  validatorFunction: (p0) {},
                  isPassword: true,
                ),

                const SizedBox(height: 75),

                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if(state is LoginSuccessfully){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>MainLayout()), (route)=>false);
                      showAppSnackBar(
                        context,
                        "",
                        "",
                        ContentType.success,
                      );
                      
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kPrimaryColor,
                        ),
                      );
                    }
                    return MyButton(
                      text: "Login",
                      function: () {
                        if (_formKey.currentState!.validate()) {
                          AuthCubit.get(context).login(
                            email: _emailController.text,
                            password: _passwordController.text,
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
                      "Don't have an account? ",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    GestureDetector(
                      onTap: ()=>Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_)=>RegisterScreen())
                      ),
                      child: Text(
                        "Register",
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

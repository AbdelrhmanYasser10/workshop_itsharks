import 'package:e_commerce_platzi/services/network/local/cache_helper/cache_helper.dart';
import 'package:e_commerce_platzi/utlis/app_text_styles.dart';
import 'package:e_commerce_platzi/view_model/home_cubit/home_cubit.dart';
import 'package:e_commerce_platzi/view_model/theme_cubit/theme_cubit.dart';
import 'package:e_commerce_platzi/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import '../../utlis/app_colors.dart';
import '../../utlis/routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          if (cubit.user == null || state is GetProfileLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.kPrimaryColor),
            );
          }
          _emailController.text = cubit.user!.email!;
          _usernameController.text = cubit.user!.name!;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 54,
                      backgroundColor: AppColors.kPrimaryColor,
                      child: CircleAvatar(
                        radius: 52,
                        backgroundImage: NetworkImage(cubit.user!.avatar!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  MyTextFormField(
                    hintText: "",
                    prefixIcon: LineIcons.envelope,
                    enable: false,
                    controller: _emailController,
                    validatorFunction: (p0) {},
                  ),
                  const SizedBox(height: 10.0),
                  MyTextFormField(
                    hintText: "",
                    prefixIcon: LineIcons.pen,
                    enable: false,
                    controller: _usernameController,
                    validatorFunction: (p0) {},
                  ),
                  const SizedBox(height: 10.0),
                  Text("Settings", style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 10.0),
                  buildOptionCard(
                    title: "Dark Theme",
                    onPressed: () {},
                    icon: LineIcons.moon,
                    optionWidget: BlocConsumer<ThemeCubit, ThemeState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Switch(
                          value: ThemeCubit.get(context).isDark,
                          onChanged: (value) {
                            ThemeCubit.get(context).changeTheme(newVal: value);
                          },
                          inactiveThumbColor: Colors.white,
                          activeColor: AppColors.kPrimaryColor,
                        );
                      },
                    ),
                  ),
                  buildOptionCard(
                    title: "Log out",
                    onPressed: () {
                      SharedPreferencesHelper.removeData(key: "token");
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRouter.LoginScreen,
                        (route) => false,
                      );
                    },
                    icon: LineIcons.alternateSignOut,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  GestureDetector buildOptionCard({
    required IconData icon,
    required String title,
    Widget? optionWidget,
    required VoidCallback onPressed,
  }) {
    var isDarkMood = ThemeCubit.get(context).isDark;
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: isDarkMood ?Colors.black : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        elevation: 2,
        child: ListTile(
          leading: Icon(icon, color: isDarkMood ?Colors.white:Colors.black),
          title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
          trailing: optionWidget,
        ),
      ),
    );
  }
}

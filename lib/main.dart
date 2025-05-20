import 'package:e_commerce_platzi/services/network/local/cache_helper/cache_helper.dart';
import 'package:e_commerce_platzi/services/network/remote/dio_helper/dio_helper.dart';
import 'package:e_commerce_platzi/utlis/app_router.dart';
import 'package:e_commerce_platzi/utlis/routes.dart';
import 'package:e_commerce_platzi/view_model/authentication/auth_cubit.dart';
import 'package:e_commerce_platzi/view_model/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_master/core/splash_master.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  SplashMaster.initialize();

  DioHelper.init();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) =>
          HomeCubit()
            ..getProfile()
            ..getCategories()
            ..getTopProducts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.SplashScreen,
        onGenerateRoute: onGenerate,
      ),
    );
  }
}

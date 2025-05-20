import 'package:bloc/bloc.dart';
import 'package:e_commerce_platzi/services/network/local/cache_helper/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  static ThemeCubit get(context)=>BlocProvider.of(context);
  late bool isDark;
  void loadFromCache(){
    isDark = SharedPreferencesHelper.getData(key: "isDark") ?? false;
    emit(LoadThemeFromCache());
  }

  void changeTheme({required bool newVal})async{
    isDark = newVal;
    await SharedPreferencesHelper.saveData(key: "isDark", value: isDark);
    emit(ChangeThemeState());

  }

}

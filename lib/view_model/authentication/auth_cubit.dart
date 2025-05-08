import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context)=>BlocProvider.of(context);

  final ImagePicker picker = ImagePicker();
  XFile? image;


  void getImage(String source)async{
    if(source =="camera"){
      image = await picker.pickImage(source: ImageSource.camera);
      if(image != null){
        emit(PickImageSuccessfully());
      }
      else{
        emit(PickImageError());
      }
    }
    else{
      image = await picker.pickImage(source: ImageSource.gallery);
      if(image != null){
        emit(PickImageSuccessfully());
      }
      else{
        emit(PickImageError());
      }
    }
  }

  void uploadImage(){}

  void register(){}
}

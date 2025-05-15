import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_platzi/services/network/local/cache_helper/cache_helper.dart';
import 'package:e_commerce_platzi/services/network/remote/dio_helper/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../utlis/app_colors.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  final ImagePicker picker = ImagePicker();
  XFile? image;
  CroppedFile? croppedImage;

  String? imageLink;

  void getImage(String source) async {
    if (source == "camera") {
      image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        emit(PickImageSuccessfully());
      } else {
        emit(PickImageError());
      }
    } else {
      image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        emit(PickImageSuccessfully());
      } else {
        emit(PickImageError());
      }
    }
  }

  void cropImage() async {
    croppedImage = await ImageCropper().cropImage(
      sourcePath: image!.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColors.kPrimaryColor,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
      ],
    );
    if (croppedImage == null) {
      emit(CropImageError());
    } else {
      emit(CropImageSuccessfully());
    }
  }

  Future<void> uploadImage() async {
    emit(UploadImageLoading());
    try {
      Response response = await DioHelper.uploadFiles(
        endpoint: "files/upload",
        body: FormData.fromMap({
          "file": await MultipartFile.fromFile(
            croppedImage!.path,
            filename: croppedImage!.path.split("/").last,
          ),
        }),
      );
      imageLink = response.data["location"];
      emit(UploadImageSuccessfully());
    } catch (error) {
      emit(UploadImageError());
    }
  }

  void register({
    required String email,
    required String password,
    required String username,
  }) async {
    emit(RegisterLoading());
    try {
      await uploadImage();

      Response response = await DioHelper.postRequest(
        endpoint: "users/",
        body: {
          "email": email,
          "password": password,
          "name": username,
          "avatar": imageLink,
        },
      );
      if (response.statusCode == 201) {
        print(response.data);
        emit(RegisterSuccessfully());
      } else {
        print(response.data);
        emit(RegisterError());
      }
    } catch (error) {
      print(error);
      emit(RegisterError());
    }
  }

  void login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      Response response = await DioHelper.postRequest(
        endpoint: "auth/login",
        body: {"email": email, "password": password},
      );
      print(response.data);
      if(response.statusCode == 201) {
        // cache token
        await SharedPreferencesHelper.saveData(key: "token",
            value: response.data["access_token"]); // caching (important !!!)
        emit(LoginSuccessfully());
      }
      else{
        emit(LoginError(response.data["message"]));
      }
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }
}

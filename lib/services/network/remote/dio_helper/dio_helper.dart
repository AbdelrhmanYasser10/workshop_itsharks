
import 'package:dio/dio.dart';

abstract class DioHelper{

  static Dio? _dio; // Encapsulation

  static void init(){
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://api.escuelajs.co/api/v1/",
        connectTimeout: const Duration(seconds: 20),
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          return status! <= 505;
        },
      ),
    );
  }


  static Future<Response> postRequest({
  required String endpoint,
    Map<String,dynamic>? body,
    Map<String,dynamic>? query,
  })async{

    return await _dio!.post(
      endpoint,
      data: body,
      queryParameters: query,
    );
  }


  static Future<Response> uploadFiles({
    required String endpoint,
    FormData? body,
  })async{
    _dio!.options.headers["Content-Type"] ="multipart/form-data";
    return await _dio!.post(
      endpoint,
      data: body,
    );
  }
}
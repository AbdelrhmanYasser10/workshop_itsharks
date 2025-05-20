import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_platzi/model/category_model/category_model.dart';
import 'package:e_commerce_platzi/model/product_model/product_model.dart';
import 'package:e_commerce_platzi/model/user_model/user_model.dart';
import 'package:e_commerce_platzi/services/network/local/cache_helper/cache_helper.dart';
import 'package:e_commerce_platzi/services/network/remote/dio_helper/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context)=>BlocProvider.of(context);

  UserModel? user;
  List<ProductModel> allProducts = [];
  List<CategoryModel> allCategories = [];
  List<ProductModel> allProductsFromCategory = [];
  List<ProductModel> allProductsFromSearch = [];

  void getProfile() async{
    emit(GetProfileLoading());
    try {
      Response r = await DioHelper.getData(
          endpoint: "auth/profile",
        token: SharedPreferencesHelper.getData(key: "token"),
      );
      if(r.statusCode == 200){
        user = UserModel.fromJson(r.data);
        emit(GetProfileSuccessfully());
      }
      else{
        await SharedPreferencesHelper.removeData(key: "token");
        emit(GetProfileError());
      }
    }catch(error){
      emit(GetProfileError());
    }
  }
  
  void getCategories()async{
    emit(GetCategoriesLoading());
    allCategories = [];
    try{
      Response r = await DioHelper.getData(endpoint: "categories/");
      if(r.statusCode == 200){
        for(int i = 0 ; i < 5;i++){
          CategoryModel currentCategory = CategoryModel.fromJson(r.data[i]);
          allCategories.add(currentCategory);
        }

        emit(GetCategoriesSuccessfully());
      }
      else{
        emit(GetCategoriesError());

      }
    }catch(err){
      emit(GetCategoriesError());
    }
  }
  
  void getTopProducts()async{
    emit(GetProductsLoading());
    try{
      Response response = await DioHelper.getData(endpoint: "products/");
      if(response.statusCode == 200){
        for(int i = 0 ; i < 10;i++){
          ProductModel currProduct = ProductModel.fromJson(response.data[i]);
          allProducts.add(currProduct);
        }
        emit(GetProductsSuccessfully());
      }
      else{
        emit(GetProductsError());

      }
    }catch(err){
      emit(GetProductsError());
    }
  }
  
  void getProductsFromCategory({
  required int categoryId
})async{
    emit(GetProductsFromCategoryLoading());
    allProductsFromCategory = [];
    try{
      Response result = await DioHelper.getData(
          endpoint: "products/",
        queryParams: {
            "categoryId":categoryId
        },
      );
      if(result.statusCode == 200){
        result.data.forEach((element){
          ProductModel currProduct = ProductModel.fromJson(element);
          allProductsFromCategory.add(currProduct);
        });
        emit(GetProductsFromCategorySuccessfully());
      }
      else{
        emit(GetProductsFromCategoryError());

      }

    }catch(error){
      emit(GetProductsFromCategoryError());
    }
  }

  void getProductsFromSearch({
    required String keyWord
  })async{
    emit(GetProductsFromSearchLoading());
    allProductsFromSearch = [];
    try{
      Response result = await DioHelper.getData(
        endpoint: "products/",
        queryParams: {
          "title":keyWord
        },
      );
      if(result.statusCode == 200){
        result.data.forEach((element){
          ProductModel currProduct = ProductModel.fromJson(element);
          allProductsFromSearch.add(currProduct);
        });
        emit(GetProductsFromSearchSuccessfully());
      }
      else{
        emit(GetProductsFromSearchError());

      }

    }catch(error){
      emit(GetProductsFromCategoryError());
    }
  }
}

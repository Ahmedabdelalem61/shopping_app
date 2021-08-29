import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/models/shop_app/login_model/login_model.dart';
import 'package:task_todo/modules/shop_app/cubit/states.dart';
import 'package:task_todo/shared/components/constants.dart';
import 'package:task_todo/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) =>BlocProvider.of(context);
  void userLogin({
  @required String email,
  @required String password,
}){
    ShopLoginModel loginModel;
    emit(ShopLoginLoadinState());
    DioHelper.postData(url: LOGIN, data: {
      'email':email,
      'password':password,
    }).then((value){

      print(value.data);
      loginModel = ShopLoginModel.FromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
      print(loginModel.status);
      print(loginModel.message);
      print(loginModel.data.token);
    }).catchError((error){
      emit(ShopLoginErrorState(error));
      print(error.toString());
    });
  }
  IconData suuffix = Icons.visibility;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    isPassword?suuffix= Icons.visibility:suuffix = Icons.visibility_off_outlined;
    emit(ShopLoginChangeVisibilityState());
  }

}
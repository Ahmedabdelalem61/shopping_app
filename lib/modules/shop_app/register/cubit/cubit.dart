import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/models/shop_app/login_model/login_model.dart';
import 'package:task_todo/modules/shop_app/cubit/states.dart';
import 'package:task_todo/modules/shop_app/register/cubit/states.dart';
import 'package:task_todo/shared/components/constants.dart';
import 'package:task_todo/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) =>BlocProvider.of(context);
  void userRegister({
  @required String email,
  @required String password,
  @required String phone,
  @required String name,
}){
    ShopLoginModel loginModel;
    emit(ShopRegisterLoadinState());
    DioHelper.postData(url: REGISTER, data: {
      'name':name,
      'email':email,
      'password':password,
      'phone':phone,
    }).then((value){

      print(value.data);
      loginModel = ShopLoginModel.FromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
      print(loginModel.status);
      print(loginModel.message);
      print(loginModel.data.token);
    }).catchError((error){
      emit(ShopRegisterErrorState(error));
      print(error.toString());
    });
  }
  IconData suuffix = Icons.visibility;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    isPassword?suuffix= Icons.visibility:suuffix = Icons.visibility_off_outlined;
    emit(ShopRegisterChangeVisibilityState());
  }

}
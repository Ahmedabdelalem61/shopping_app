import 'package:task_todo/models/shop_app/login_model/login_model.dart';

abstract class ShopRegisterStates{}
class ShopRegisterInitialState extends ShopRegisterStates{}
class ShopRegisterLoadinState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates{
  ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}
class ShopRegisterErrorState extends ShopRegisterStates{
  final String  error;
  ShopRegisterErrorState(this.error);
}
class ShopRegisterChangeVisibilityState extends ShopRegisterStates{}

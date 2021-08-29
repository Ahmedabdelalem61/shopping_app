import 'package:task_todo/models/shop_app/login_model/login_model.dart';

abstract class ShopLoginStates{}
class ShopLoginInitialState extends ShopLoginStates{}
class ShopLoginLoadinState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates{
  ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}
class ShopLoginErrorState extends ShopLoginStates{
  final String  error;
  ShopLoginErrorState(this.error);
}
class ShopLoginChangeVisibilityState extends ShopLoginStates{}

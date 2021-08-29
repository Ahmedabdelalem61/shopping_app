import 'package:task_todo/models/shop_app/change_fav_models/change_favorites_model.dart';
import 'package:task_todo/models/shop_app/login_model/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErorrgHomeDataState extends ShopStates{
String erorr;
ShopErorrgHomeDataState(this.erorr);
}

class ShopSuccessCategoriesState extends ShopStates{}
class ShopErorrgCategoriesState extends ShopStates{
  String erorr;
  ShopErorrgCategoriesState(this.erorr);
}

class ShopChangeFavoritesState extends ShopStates{}
class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErorrChangeFavoritesState extends ShopStates{
  String erorr;
  ShopErorrChangeFavoritesState(this.erorr);
}

class ShopSuccessFavoritesState extends ShopStates{}
class ShopErorrgFavoritesState extends ShopStates{
  String erorr;
  ShopErorrgFavoritesState(this.erorr);
}
class ShopLoadingGetFavoritesState extends ShopStates{}


class ShopLoadingGetProfileDataState extends ShopStates{}
class ShopSuccessGetProfileDataState extends ShopStates{}
class ShopErorrgGetProfileDataState extends ShopStates{
  String erorr;
  ShopErorrgGetProfileDataState(this.erorr);
}



class ShopLoadingUpdateUserDataState extends ShopStates{}
class ShopSuccessUpdateUserDataState extends ShopStates{
  final ShopLoginModel model;
  ShopSuccessUpdateUserDataState(this.model);
}
class ShopErorrgUpdateUserDataState extends ShopStates{
  String erorr;
  ShopErorrgUpdateUserDataState(this.erorr);
}
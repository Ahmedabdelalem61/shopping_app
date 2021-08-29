import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/shop_app/cubit/states.dart';
import 'package:task_todo/models/favorites/favorites.dart';
import 'package:task_todo/models/shop_app/categories_model/categories_model.dart';
import 'package:task_todo/models/shop_app/change_fav_models/change_favorites_model.dart';
import 'package:task_todo/models/shop_app/home_model/home_model.dart';
import 'package:task_todo/models/shop_app/login_model/login_model.dart';
import 'package:task_todo/modules/shop_app/categories/categories.dart';
import 'package:task_todo/modules/shop_app/favorites/favorites.dart';
import 'package:task_todo/modules/shop_app/products/products.dart';
import 'package:task_todo/modules/shop_app/settings/settings.dart';
import 'package:task_todo/shared/components/constants.dart';
import 'package:task_todo/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> Screens = [Products(), Categories(), Favorites(), Settings()];

  void changeBottom(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  bool checkFav = false;
  Map<int,bool> favorites = {};
  HomeModel homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
       printFullText(homeModel.toString());
       print(homeModel.status);
      print(homeModel.data.banners[0].image);
      homeModel.data.products.forEach((element) {
        element.inFavorite?checkFav =true:print('done');
        favorites.addAll({element.id:element.inFavorite});
      });
      print(favorites);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErorrgHomeDataState(error.toString()));
    });
  }

  CategoriesModel categoriesModel;
  void getCategoriesData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: CATEGORIES,).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErorrgCategoriesState(error));
    });
  }

  bool CheckFav(){
    int counter = 0;
    favorites.map((key, value) {
      if(value==false){
        counter++;
      }
    }
    );
    if(counter==favorites.length){
      return false;
    }
    return true;
  }

  ChangeFavoritesModel changeFavoritesModel;
   void changeFavorites(int productId){
    favorites[productId]= !favorites[productId];
    emit(ShopChangeFavoritesState());
    DioHelper.postData(url: FAVORITES, data: {
      'product_id':productId
    },token: token).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if(!changeFavoritesModel.status)
        favorites[productId]= !favorites[productId];
      else{
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((erorr){
      print(erorr);
      if(!changeFavoritesModel.status)
        favorites[productId]= !favorites[productId];
      emit(ShopErorrgCategoriesState(erorr));
    });
   }

   FavoritesModel favoritesModel;
  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES,token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErorrgFavoritesState(error));
    });
  }


  ShopLoginModel userData;
  void getUserData() {
    emit(ShopLoadingGetProfileDataState());
    DioHelper.getData(url: PROFILE,token: token).then((value) {
      userData = ShopLoginModel.FromJson(value.data);
      print(value.data);
      emit(ShopSuccessGetProfileDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErorrgGetProfileDataState(error));
    });
  }

  void updateUserData({
  @required String name,
    @required String email,
    @required String phone,
}) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(url: UPDATE_PROFILE,token: token,data: {
      'name':name,
      'email':email,
      'phone':phone
    }).then((value) {
      userData = ShopLoginModel.FromJson(value.data);
      print(value.data);
      emit(ShopSuccessUpdateUserDataState(userData));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErorrgUpdateUserDataState(error));
    });
  }
}

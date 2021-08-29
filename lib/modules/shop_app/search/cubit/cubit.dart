import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/models/shop_app/search_model/search_model.dart';
import 'package:task_todo/modules/shop_app/search/cubit/states.dart';
import 'package:task_todo/shared/components/constants.dart';
import 'package:task_todo/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(InitialSearchState());

  static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel searchModel;
  int items = 0;
  void search(String text){
    emit(SearchloadingState());
    DioHelper.postData(url: SEARCH,token: token, data: {
      'text':text,
    }).then((value){
      searchModel = SearchModel.fromJson(value.data);
      items =searchModel.data.data.length;
      emit(SearchSuccessState());
    }).catchError((erorr){
      print(erorr.toString());
      emit(SearchErorrState());
    });
  }



}
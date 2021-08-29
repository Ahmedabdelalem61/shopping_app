import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/cubit/cubit_states.dart';
import 'package:task_todo/modules/news_app/business/businees_screen.dart';
import 'package:task_todo/modules/news_app/science/science_screen.dart';
import 'package:task_todo/modules/news_app/settings/settings.dart';
import 'package:task_todo/modules/news_app/sports/sports_screen.dart';
import 'package:task_todo/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(initialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int CurrentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'Business'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: 'Sports'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'Science'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.settings,
        ),
        label: 'Settings'),

  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];
  void changeBottomNavBar(int index){
    CurrentIndex = index;
    if(index==1){
      getSportsData();
    }
    else if(index==2){
      getScienceData();
    }

    emit(BotomNavBarState());
  }
  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  void getBusinessData(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines',
    query:
    {
      'country':'eg',
      'category':'business',
      'apiKey':'f4f0fdc498134552b19c934d13d612cf',//65f7f556ec76449fa7dc7c0069f040ca
    }).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
      print(business[0]['title']) ;
    }).catchError((err){
      emit(NewsGetBusinessErrorState(err));
      print("${err.toString()} sooooooooooooooooo");
    });
  }
  void getSportsData(){
    emit(NewsGetSportsLoadingState());
    if(sports.length==0){
      DioHelper.getData(url: 'v2/top-headlines',
          query:
          {
            'country':'eg',
            'category':'sports',
            'apiKey':'f4f0fdc498134552b19c934d13d612cf',
          }).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
        print(sports[0]['title']) ;
      }).catchError((err){
        emit(NewsGetSportsErrorState(err));
        print(err.toString());
      });
    }else
      {
        emit(NewsGetSportsSuccessState());
      }
  }
  void getScienceData(){
    emit(NewsGetScienceLoadingState());
    if(science.length==0){
      DioHelper.getData(url: 'v2/top-headlines',
          query:
          {
            'country':'eg',
            'category':'science',
            'apiKey':'f4f0fdc498134552b19c934d13d612cf',
          }).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
        print(science[0]['title']) ;
      }).catchError((err){
        emit(NewsGetScienceErrorState(err));
        print(err.toString());
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }
  }


  List<dynamic> search = [];
  void getSearch(String value){
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: 'v2/everything',
        query:
        {
          'q':'$value',
          'apiKey':'f4f0fdc498134552b19c934d13d612cf',
        }).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
      print(search[0]['title']) ;
    }).catchError((err){
      emit(NewsGetSearchErrorState(err));
      print(err.toString());
    });
  }
}

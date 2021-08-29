//https://newsapi.org/v2/everything?q=tesla&apiKey=f4f0fdc498134552b19c934d13d612cf
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_todo/modules/shop_app/login/login_screen.dart';
import 'package:task_todo/shared/network/local/cashe_helper.dart';

import 'news_component.dart';

const  LOGIN = 'login';
const  REGISTER = 'register';
const  HOME = 'home';
const  CATEGORIES = 'categories';
const  FAVORITES = 'favorites';
const  PROFILE = 'profile';
const  UPDATE_PROFILE = 'update-profile';
const  SEARCH = 'products/search';




Color defaultColor = Colors.blue;
void signOut(context){
  CasheHelper.removeData('token').then((value) {
    if(value)navigateAndFinish(context, ShopLoginScreen());
  });
}

//print full text
void printFullText(String text){
 final pattern = RegExp('.{1.800}');
 pattern.allMatches(text).forEach((match) =>print(match.group(0)));
}
String token = "";
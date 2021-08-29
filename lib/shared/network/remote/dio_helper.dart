import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_todo/shared/components/constants.dart';

class DioHelper{
  static Dio dio;
  static init()
  {
    dio = Dio(
        BaseOptions(
            baseUrl: 'https://student.valuxapps.com/api/',
            receiveDataWhenStatusError: true,

        )
    );
  }
  static Future<Response>  getData({
    @required String url,
     Map<String,dynamic> query,
    String lang = 'en',
    String token  ,
   }
   )async{
    dio.options.headers = {
      'lang':lang,
      'Authorization':token??'',
      'Content-Type':'application/json'
    };
   return await dio.get(url,queryParameters: query??null);
  }

  static Future<Response>  postData({
    @required String url,
    Map<String,dynamic> query,
    @required Map<String,dynamic> data,
    String lang = 'en',
    String token
  }
      )async{
    dio.options.headers = {
      'lang':lang,
      'Authorization':token??'',
      'Content-Type':'application/json'
    };
    return dio.post(url,data: data,queryParameters: query??null);
  }

  static Future<Response>  putData({
    @required String url,
    Map<String,dynamic> query,
    @required Map<String,dynamic> data,
    String lang = 'en',
    String token
  }
      )async{
    dio.options.headers = {
      'lang':lang,
      'Authorization':token??'',
      'Content-Type':'application/json'
    };
    return dio.put(url,data: data,queryParameters: query??null);
  }
}
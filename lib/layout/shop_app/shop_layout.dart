import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/shop_app/cubit/cubit.dart';
import 'package:task_todo/layout/shop_app/cubit/states.dart';
import 'package:task_todo/modules/shop_app/login/login_screen.dart';
import 'package:task_todo/modules/shop_app/search/search.dart';
import 'package:task_todo/shared/components/news_component.dart';
import 'package:task_todo/shared/network/local/cashe_helper.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('HOME'),
              actions: [
                IconButton(icon: Icon(Icons.search),onPressed: (){
                  navigateTo(context, Search());
                },),
              ],
            ),
            body: cubit.Screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottom(index);
              },
              items: [
                BottomNavigationBarItem(icon:Icon(Icons.home) ,label:'home' ),
                BottomNavigationBarItem(icon:Icon(Icons.category_outlined) ,label:'categories' ),
                BottomNavigationBarItem(icon:Icon(Icons.favorite) ,label:'favorites' ),
                BottomNavigationBarItem(icon:Icon(Icons.settings) ,label:'settings' ),
              ],
            ),
          );
        });
  }
}
/**/

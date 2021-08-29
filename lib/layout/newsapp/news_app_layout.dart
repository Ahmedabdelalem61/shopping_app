import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/cubit/cubitB.dart';
import 'package:task_todo/layout/cubit/cubit_states.dart';
import 'package:task_todo/modules/news_app/search_screen/search_screen.dart';
import 'package:task_todo/shared/components/news_component.dart';
import 'package:task_todo/shared/cubit/cubit.dart';
import 'package:task_todo/shared/network/remote/dio_helper.dart';

class NewsAppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusinessData(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          var Cubitb = NewsCubit.get(context);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(
                AppCubit.get(context).isDark
                    ? Icons.lightbulb_outline
                    : Icons.lightbulb,
                color:
                    AppCubit.get(context).isDark ? Colors.white : Colors.black,
              ),
              onPressed: () {
                AppCubit.get(context).ChangeThemeMode();
              },
            ),
            body: Cubitb.screens[Cubitb.CurrentIndex],
            appBar: AppBar(
              actions: [IconButton(icon: Icon(Icons.search), onPressed: () {
                navigateTo(context, SearchScreen());
              })],
              title: Text('News me'),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) => Cubitb.changeBottomNavBar(index),
              items: Cubitb.bottomItems,
              currentIndex: Cubitb.CurrentIndex,
              type: BottomNavigationBarType.fixed,
            ),
          );
        },
      ),
    );
  }
}

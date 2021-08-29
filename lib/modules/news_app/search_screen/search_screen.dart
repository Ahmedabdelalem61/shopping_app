import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/cubit/cubitB.dart';
import 'package:task_todo/layout/cubit/cubit_states.dart';
import 'package:task_todo/shared/components/component.dart';
import 'package:task_todo/shared/components/news_component.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(

            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  DefaultTextFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'search must not be empty';
                        }
                        return null;
                      },
                      onChange: (value){
                        NewsCubit.get(context).getSearch(value);
                      },
                      label: 'search',
                      prefix: Icons.search),
                  Expanded(child: ArticleBuilder(list, context,isSearch: true)),
                ],
              ),
            ),
          );
        }
    );
  }
}

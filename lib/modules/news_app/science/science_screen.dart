
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/cubit/cubitB.dart';
import 'package:task_todo/layout/cubit/cubit_states.dart';
import 'package:task_todo/shared/components/news_component.dart';

class ScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).science;
        return ArticleBuilder(list, context);
      },
    );
  }
}

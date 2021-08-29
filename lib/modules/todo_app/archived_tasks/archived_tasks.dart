import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/shared/components/component.dart';
import 'package:task_todo/shared/cubit/cubit.dart';
import 'package:task_todo/shared/cubit/cubitStates.dart';

class ArchivedTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).archivetasks;
        return ListView.separated(
            itemBuilder: (context, index) =>
                WidgetBuildTaskItem(tasks[index], context),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Divider(
                    color: Colors.grey[400],
                  ),
                ),
            itemCount: tasks.length);
      },
    );
  }
}

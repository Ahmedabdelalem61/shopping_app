import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_todo/shared/components/component.dart';
import 'package:task_todo/shared/cubit/cubit.dart';
import 'package:task_todo/shared/cubit/cubitStates.dart';

class HomeLayout extends StatelessWidget {
  Database dataBase;

  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   createDataBase();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if(state is AppInsertDataBaseState){
             Navigator.of(context).pop();
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: ConditionalBuilder(
              condition: cubit.tasks.length!=0,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    CircularProgressIndicator(
                    ),
                    SizedBox(height: 25,),
                    Text('it seems that no inserted tasks ',style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),)
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // insertToDataBase();
                if (cubit.isBottomshowen) {
                  if (formkey.currentState.validate()) {
                    cubit.insertToDataBase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                    // insertToDataBase(
                    //         time: timeController.text.toString(),
                    //         date: dateController.text.toString(),
                    //         title: titleController.text.toString())
                    //     .then((value) {
                    //   Navigator.of(context).pop();
                    //   getDataFromDataBase(dataBase).then((value) {
                    //     // setState(() {
                    //     //   tasks = value;
                    //     //   fabIcon = Icons.add;
                    //     //   isBottomshowen = false;
                    //     //   print(tasks);
                    //     //   NewTasks();
                    //     // });
                    //   });
                    // });
                  }
                } else {

                  scaffoldkey.currentState
                      .showBottomSheet((context) => Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
                            child: Form(
                              key: formkey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  DefaultTextFormField(
                                      controller: titleController,
                                      type: TextInputType.text,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return 'title must not be empty';
                                        }
                                        return null;
                                      },
                                      label: 'Task title',
                                      prefix: Icons.title),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  DefaultTextFormField(
                                      controller: timeController,
                                      type: TextInputType.datetime,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return 'time must not be empty';
                                        }
                                        return null;
                                      },
                                      label: 'Task time',
                                      prefix: Icons.watch_later_outlined,
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          timeController.text =
                                              value.format(context).toString();
                                          print(value.format(context));
                                        });
                                      }),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  DefaultTextFormField(
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:
                                              DateTime.parse('2022-12-12'),
                                        ).then((value) {
                                          print(
                                              DateFormat.yMMMd().format(value));
                                          dateController.text =
                                              DateFormat.yMMMd().format(value);
                                        });
                                      },
                                      controller: dateController,
                                      type: TextInputType.datetime,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return 'date must not be empty';
                                        }
                                        return null;
                                      },
                                      label: 'Task date',
                                      prefix: Icons.calendar_today),
                                ],
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cubit.ChangeBottomSheetState(
                        icon: Icons.edit, isShow: false);
                  });
                  cubit.ChangeBottomSheetState(icon: Icons.add, isShow: true);
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                // setState(() {
                //   currentIndex = index;
                // });
                cubit.changeIndex(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu), label: 'add task'),
                BottomNavigationBarItem(icon: Icon(Icons.check), label: 'done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'archived'),
              ],
            ),
          );
        },
      ),
    );
  }
}

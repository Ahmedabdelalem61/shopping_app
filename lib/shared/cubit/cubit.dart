import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_todo/modules/todo_app/archived_tasks/archived_tasks.dart';
import 'package:task_todo/modules/todo_app/done_tasks/done%20tasks.dart';
import 'package:task_todo/modules/todo_app/new_tasks/new_tasks.dart';
import 'package:task_todo/shared/cubit/cubitStates.dart';
import 'package:task_todo/shared/network/local/cashe_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(initialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [NewTasks(), DoneTasks(), ArchivedTasks()];
  List<String> titles = ['new task', 'done task', 'archive task'];
  List<Map> tasks = [];
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeNavBarState());
  }

  Database dataBase;

  void createDataBase() {
    openDatabase('todo.db', version: 1, onCreate: (dataBase, version) {
      print('data base are created');
      dataBase
          .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT)')
          .then((value) {
        print('table are created');
      }).catchError((error) {
        print('there are ${error} error'.toString());
      });
    }, onOpen: (dataBase) {
      getDataFromDataBase(dataBase);
      print('data base opened');
    }).then((value) {
      dataBase = value;
      emit(AppCreateDataBaseState());
    });
  }

  void getDataFromDataBase(dataBase) {
    newtasks = [];
    donetasks = [];
    archivetasks = [];
    dataBase.rawQuery('SELECT * FROM tasks').then((value) {
      tasks = value;
      print(tasks);
      emit(AppGetDataBaseState());
      tasks.forEach((element) {
        if (element['status'] == 'new')
          newtasks.add(element);
        else if (element['status'] == 'done')
          donetasks.add(element);
        else
          archivetasks.add(element);
        print(element['status']);
      });
    });
  }

  void insertToDataBase({
    @required String title,
    @required String time,
    @required String date,
  }) async {
    await dataBase.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('${value}inserted Successfully');
        emit(AppInsertDataBaseState());
        getDataFromDataBase(dataBase);
      }).catchError((error) {
        print('error when insrting raw ${error.toString()}');
      });
      return null;
    });
  }

  void deleteFromDataBase({
    @required int id,
  }) async {
    await dataBase.transaction((txn) {
      txn.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
        emit(AppDeleteDataBaseState());
        getDataFromDataBase(dataBase);
      }).catchError((error) {
        print('error when Deleting raw ${error.toString()}');
      });
      return null;
    });
  }

  void updateDateBase({
    @required String status,
    @required int id,
  }) async {
    dataBase.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      emit(AppUpdaeDataBaseState());
      getDataFromDataBase(dataBase);
    });
  }

  bool isBottomshowen = false;
  IconData fabIcon = Icons.add;

  void ChangeBottomSheetState(
      {@required IconData icon, @required bool isShow}) {
    isBottomshowen = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  bool isDark = false;

  void ChangeThemeMode({bool fromSharedPreferences}) {
    if (fromSharedPreferences != null) {
      isDark = fromSharedPreferences;
      emit(ChangeThemeModeState());
    } else {
      isDark = !isDark;
      CasheHelper.putData('isDark', isDark);
      emit(ChangeThemeModeState());
    }
  }
}

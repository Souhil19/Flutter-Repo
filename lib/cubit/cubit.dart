import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite/cubit/states.dart';
import 'package:infinite/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:infinite/modules/done_tasks/done_tasks_screen.dart';
import 'package:infinite/modules/new_tasks/new_tasks_screen.dart';
import 'package:sqflite/sqflite.dart';


class AppCubit extends Cubit<AppStates>{
  AppCubit(): super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<String> titles = [
    'Time App > New Tasks',
    'Time App > Done Tasks',
    'Time App > Archived Tasks',
  ];

  Database database;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archivedTasks=[];

  bool isBottomSheet =false;
  IconData fabIcon = Icons.edit;

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) async {
        print('database created');
        database
            .execute(
            'create table tasks(id integer primary key,title text,date text, time text, status text)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error when creating table');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database opened');
      },
    ).then((value) {
      database =value;
      emit(AppCreateDatabaseState());
    });
  }

  Future insertToDatabase({
      @required String title,
      @required String time,
      @required String date,
       }) async{
    await database.transaction((txn) {
      txn
          .rawInsert(
          'Insert into tasks(title,time,date,status) Values("$title","$time","$date","new")')
          .then((value) {
        print('$value inserted succesfully');

        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('ERROR ${error.toString()}');
      });

      return null;
    });
  }

  void getDataFromDatabase(database) {
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];

    database.rawQuery('select * from tasks').then((value) {

      print(value);
      value.forEach((element) {
        if(element['status']=='new')
          newTasks.add(element);
        else if (element['status']=='done')
          doneTasks.add(element);
        else archivedTasks.add(element);
      });
      emit(AppGetDatabaseState());
    });

  }

  void updateData({
      @required String status,
      @required int id,
      }) async{
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
          getDataFromDatabase(database);
          emit(AppUpdateDatabaseState());
    });

  }

  void deleteData({
    @required int id,
  }) async{
    database.rawDelete(
        'DELETE from tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });

  }

  void changeIndex(int index){
    currentIndex=index;
    emit(AppChangeBottomNavBarState());
  }

  void changeBottomSheet({
    @required bool isShow,
    @required IconData icon,
    })
  {
    isBottomSheet = isShow;
    fabIcon=icon;
    emit(AppChangeBottomSheetState());
  }

}

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite/components/constants.dart';
import 'package:infinite/cubit/cubit.dart';
import 'package:infinite/cubit/states.dart';
import 'package:infinite/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:infinite/modules/done_tasks/done_tasks_screen.dart';
import 'package:infinite/modules/new_tasks/new_tasks_screen.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state){
          if (state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state){
          AppCubit cubit= AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.deepPurpleAccent,
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
              leading: IconButton(
                icon: Icon(Icons.menu),
                tooltip: 'Menu Icon',
                onPressed: () {},
              ), //IconButton
            ),
            body: ConditionalBuilder(
              condition: true,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context)=> Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if(cubit.isBottomSheet){
                  if(formKey.currentState.validate()) {
                    cubit.insertToDatabase(title: titleController.text,
                      time: descriptionController.text,date: dateController.text,
                    );
                  }
                }else {
                  scaffoldKey.currentState.showBottomSheet<void>(
                        (context) =>
                        Container(
                          color: Colors.grey[200],
                          padding: EdgeInsets.all(20.0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: titleController,
                                    keyboardType: TextInputType.text,

                                    onFieldSubmitted: (String value){
                                      print(value);
                                    },
                                    onChanged: (String value){
                                      print(value);
                                    },
                                    decoration: InputDecoration(

                                      labelText: 'Task Title',
                                      prefixIcon: Icon(
                                        Icons.title,
                                      ),
                                      border: OutlineInputBorder(


                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  TextFormField(
                                    controller: descriptionController,
                                    keyboardType: TextInputType.datetime,
                                    onTap: (){
                                      showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                                        descriptionController.text= value.format(context).toString();
                                        print(value.format(context));
                                      } );
                                    },
                                    onFieldSubmitted: (String value){
                                      if (value.isEmpty){
                                        return 'time must not empty';
                                      }
                                      return null;
                                    },
                                    onChanged: (String value){
                                      print(value);
                                    },
                                    decoration: InputDecoration(

                                      labelText: 'Task Time',
                                      prefixIcon: Icon(
                                        Icons.access_time_outlined,
                                      ),
                                      border: OutlineInputBorder(


                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  TextFormField(
                                    controller: dateController,
                                    keyboardType: TextInputType.datetime,
                                    onTap: (){
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2022,1,1),
                                      ).then((value) {
                                        print(DateFormat.yMMMMd().format(value));
                                        dateController.text= DateFormat.yMMMMd().format(value).toString();
                                      }
                                      );
                                    },
                                    onFieldSubmitted: (String value){
                                      if (value.isEmpty){
                                        return 'date must not empty';
                                      }
                                      return null;
                                    },
                                    onChanged: (String value){
                                      print(value);
                                    },
                                    decoration: InputDecoration(

                                      labelText: 'Task Date',
                                      prefixIcon: Icon(
                                        Icons.calendar_today,
                                      ),
                                      border: OutlineInputBorder(


                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    elevation: 20.0,
                  ).closed.then((value) {
                    cubit.changeBottomSheet(isShow: false, icon: Icons.edit);

                  });
                  cubit.changeBottomSheet(isShow: true, icon: Icons.add);
                }
              },
              backgroundColor: Colors.deepPurpleAccent,
              child: Icon(
                cubit.fabIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              //backgroundColor: Colors.deepPurpleAccent,
              currentIndex: cubit.currentIndex,
              selectedItemColor: Colors.deepPurpleAccent,
              onTap: (index) {
                cubit.changeIndex(index);
                print(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<String> getName() async {
    return 'Any mmm';
  }



}


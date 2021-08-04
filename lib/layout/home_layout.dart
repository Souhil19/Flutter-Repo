import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:infinite/components/constants.dart';
import 'package:infinite/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:infinite/modules/done_tasks/done_tasks_screen.dart';
import 'package:infinite/modules/new_tasks/new_tasks_screen.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  Database database;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheet =false;
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          titles[currentIndex],
        ),
      ),
      body: ConditionalBuilder(
        condition: tasks.length>0,
        builder: (context) => screens[currentIndex],
        fallback: (context)=> Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(isBottomSheet){
            if(formKey.currentState.validate()) {
              insertToDatabase(titleController.text,
               descriptionController.text, dateController.text,
              ).then((value) {
                Navigator.pop(context);
                isBottomSheet = false;
                setState(() {
                  fabIcon = Icons.edit;
                });
              });
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
                            SizedBox(
                              height: 40.0,
                            ),
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
                                  dateController.text= value.toString();
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

              isBottomSheet = false;
              setState(() {
                fabIcon = Icons.edit;
              });

            });
            isBottomSheet = true;
            setState(() {
              fabIcon=Icons.add;
            });
          }
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: Icon(
          fabIcon,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepPurpleAccent,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
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
  }

  Future<String> getName() async {
    return 'Any mmm';
  }

  void createDatabase() async {
    database = await openDatabase(
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
        getDataFromDatabase(database).then((value) {
          tasks=value;
          print(tasks);
        });
        print('database opened');
      },
    );
  }

  Future insertToDatabase(
      @required String title,
      @required String time,
      @required String date,
      ) async{
    return await database.transaction((txn) {
      txn
          .rawInsert(
              'Insert into tasks(title,time,date,status) Values("$title","$time","$date","new")')
          .then((value) {
        print('$value inserted succesfully');
      }).catchError((error) {
        print('ERROR ${error.toString()}');
      });

      return null;
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database.rawQuery('select * from tasks');

  }

}

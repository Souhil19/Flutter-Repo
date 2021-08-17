import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite/components/components.dart';
import 'package:infinite/cubit/cubit.dart';
import 'package:infinite/cubit/states.dart';

class ArchivedTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state){},
      builder: (context, state){
        var tasks = AppCubit.get(context).archivedTasks;
        return tasksBuilder(tasks: tasks);
      },

    );
  }
}

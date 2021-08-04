import 'package:flutter/material.dart';
import 'package:infinite/components/components.dart';
import 'package:infinite/components/constants.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index)=> buildTaskItem(tasks[index]),
        separatorBuilder: (context,index)=> Container(
          width: double.infinity,
          height: 1.0,
          color: Colors.grey[300],
        ),
        itemCount: tasks.length,
    );
  }
}

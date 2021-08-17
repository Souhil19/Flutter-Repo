import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:infinite/cubit/cubit.dart';
import 'package:sqflite/sqflite.dart';

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.deepPurpleAccent,
              radius: 40.0,
              child: Text('${model['time']}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'done', id: model['id']);
              },
              icon: Icon(
                Icons.check_circle_outline,
                color: Colors.deepPurpleAccent,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'archive', id: model['id']);
              },
              icon: Icon(
                Icons.archive_outlined,
                color: Colors.deepPurpleAccent,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );

Widget tasksBuilder({
  @required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 80.0,
              color: Colors.deepPurpleAccent[100],
            ),
            Text(
              'No Tasks Today',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent[100],
              ),
            ),
          ],
        ),
      ),
    );

Widget buildArticleItem(article)=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            )
        ),
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: Container(
          height: 120.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text('${article['title']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text('${article['publishedAt']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),


            ],
          ),
        ),
      ),
    ],
  ),
);

Widget myDivider() => Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey[300],
);

Widget articleBuilder(list)=> ConditionalBuilder(
  condition: list.length>0,
  builder: (context)=>ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index)=>buildArticleItem(list[index]),
      separatorBuilder: (context,index)=> myDivider(),
      itemCount: 15),
  fallback: (context)=>Center(child: CircularProgressIndicator()),
);

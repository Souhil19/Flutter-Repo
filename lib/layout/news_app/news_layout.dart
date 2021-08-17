import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite/layout/news_app/cubit/cubit.dart';
import 'package:infinite/layout/news_app/cubit/states.dart';
import 'package:infinite/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit,NewStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit= NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'News App',
              ),
              actions: [
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.search),
                ),
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.brightness_4_outlined),
                ),
              ],
            ),
            //floatingActionButton: FloatingActionButton(
              //icon: Icons.add,
              //onPressed: (){

              //},
            //),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItems,
              onTap: (index){
                cubit.changeBottomNavBar(index);
              },
            ),
          );
        },
      ),
    );
  }
}

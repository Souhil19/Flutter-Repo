import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite/layout/news_app/cubit/states.dart';
import 'package:infinite/modules/business/business_screen.dart';
import 'package:infinite/modules/science/science_screen.dart';
import 'package:infinite/modules/settings/settings_screen.dart';
import 'package:infinite/modules/sports/sports_screen.dart';
import 'package:infinite/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business_center,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_basketball,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];

  List<Widget> screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar (int index){
    currentIndex=index;
    if (index==1) getSports();
    if(index==2) getScience();
    emit(NewsBottomState());
  }
  List<dynamic> business=[];

  void getBusiness()
  {
    emit(NewsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country':'eg',
      'category':'business',
      'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'

    },
    ).then((value){
      //print(value.data['articles'][0]['title'].toString());
      business =value.data['articles'];
      print(business[0]['title'].toString());
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports=[];

  void getSports()
  {
    emit(NewsSportsLoadingState());

    if(sports.length==0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
      },
      ).then((value) {
        //print(value.data['articles'][0]['title'].toString());
        sports = value.data['articles'];
        print(sports[0]['title'].toString());
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science=[];

  void getScience()
  {
    emit(NewsScienceLoadingState());
    if (science.length==0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
      },
      ).then((value) {
        //print(value.data['articles'][0]['title'].toString());
        science = value.data['articles'];
        print(business[0]['title'].toString());
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else{
      emit(NewsGetScienceSuccessState());
    }
  }

}

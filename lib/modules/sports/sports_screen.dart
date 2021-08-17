import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite/components/components.dart';
import 'package:infinite/layout/news_app/cubit/cubit.dart';
import 'package:infinite/layout/news_app/cubit/states.dart';

class SportsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewStates>(
      listener: (context,state){},
      builder: (context,state){
        var list=NewsCubit.get(context).sports;
        return articleBuilder(list);
      },
    );
  }
}

abstract class NewStates{}

class NewsInitialStates extends NewStates{}

class NewsBottomState extends NewStates{}

class NewsLoadingState extends NewStates{}

class NewsGetBusinessSuccessState extends NewStates{}

class NewsGetBusinessErrorState extends NewStates{
  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsSportsLoadingState extends NewStates{}

class NewsGetSportsSuccessState extends NewStates{}

class NewsGetSportsErrorState extends NewStates{
  final String error;

  NewsGetSportsErrorState(this.error);
}

class NewsScienceLoadingState extends NewStates{}

class NewsGetScienceSuccessState extends NewStates{}

class NewsGetScienceErrorState extends NewStates{
  final String error;

  NewsGetScienceErrorState(this.error);
}


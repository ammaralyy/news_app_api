abstract class AppState{}

class AppInitState extends AppState{}

class AppChangeAppModeState extends AppState{}

class AppChangeBottomNavBarState extends AppState{}

class AppGetBusinessLoadingState extends AppState{}

class AppGetBusinessSuccessState extends AppState{}

class AppGetBusinessErrorState extends AppState{
  final String error;
  AppGetBusinessErrorState(this.error);
}

class AppGetSportsLoadingState extends AppState{}

class AppGetSportsSuccessState extends AppState{}

class AppGetSportsErrorState extends AppState{
  final String error;
  AppGetSportsErrorState(this.error);
}

class AppGetScienceLoadingState extends AppState{}

class AppGetScienceSuccessState extends AppState{}

class AppGetScienceErrorState extends AppState{
  final String error;
  AppGetScienceErrorState(this.error);
}

class AppGetSearchLoadingState extends AppState{}

class AppGetSearchSuccessState extends AppState{}

class AppGetSearchErrorState extends AppState{
  final String error;
  AppGetSearchErrorState(this.error);
}


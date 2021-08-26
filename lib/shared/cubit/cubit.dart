import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api/modules/business.dart';
import 'package:news_app_api/modules/science.dart';
import 'package:news_app_api/modules/sports.dart';
import 'package:news_app_api/shared/cubit/states.dart';
import 'package:news_app_api/shared/network/local/cache_helper.dart';
import 'package:news_app_api/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List appTitle = ['Business', 'Sports', 'Science'];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  void changeBottomApp(index) {
    currentIndex = index;

    if (index == 0)
      getBusiness();
    else if (index == 1)
      getSports();
    else if (index == 2) getScience();

    emit(AppChangeBottomNavBarState());
  }

  List screens = [
    Business(),
    Sports(),
    Science(),
  ];

  String apiKey = '71063b72a5414897b2554ac9288f293b';
  String urlOfCategories = 'v2/top-headlines';
  String urlOfSearch = 'v2/everything';

  List<dynamic> business = [];

  void getBusiness() {
    emit(AppGetBusinessLoadingState());

    DioHelper.getData(url: urlOfCategories, query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': apiKey,
    }).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);

      emit(AppGetBusinessSuccessState());
    }).catchError((err) {
      print('error in get data: ${err.toString()}');
      emit(AppGetBusinessErrorState(err.toString()));
    });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(AppGetScienceLoadingState());

    DioHelper.getData(url: urlOfCategories, query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': apiKey,
    }).then((value) {
      science = value.data['articles'];
      print(science[0]['title']);

      emit(AppGetBusinessSuccessState());
    }).catchError((err) {
      print('error in get data: ${err.toString()}');
      emit(AppGetScienceErrorState(err.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(AppGetSportsLoadingState());

    DioHelper.getData(url: urlOfCategories, query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': apiKey,
    }).then((value) {
      sports = value.data['articles'];
      print(sports[0]['title']);

      emit(AppGetSportsSuccessState());
    }).catchError((err) {
      print('error in get data: ${err.toString()}');
      emit(AppGetSportsErrorState(err.toString()));
    });
  }

  List<dynamic> search = [];

  void getSearch(String value)
  {
    emit(AppGetSearchLoadingState());

    search = [];

    DioHelper.getData(url: urlOfSearch,
        query: {
      'q': value,
      'apiKey': apiKey,
    }).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);

      emit(AppGetSearchSuccessState());
    }).catchError((err) {
      print('error in get data: ${err.toString()}');
      emit(AppGetSearchErrorState(err.toString()));
    });
  }

  String isDarkKey = 'isDark';
  bool isDark = false;

  void appModeChange({bool? isDarkFromShared}) {
    if (isDarkFromShared != null) {
      isDark = isDarkFromShared;
      emit(AppChangeAppModeState());
    } else {
      isDark = !isDark;

      CacheHelper.putData(key: isDarkKey, isDark: isDark)
          .then((value) {
        emit(AppChangeAppModeState());
      });
    }
  }
}

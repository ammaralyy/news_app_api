import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api/shared/components/components.dart';
import 'package:news_app_api/shared/cubit/cubit.dart';
import 'package:news_app_api/shared/cubit/states.dart';

class Science extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state){},
      builder: (context, state){

        var list = AppCubit.get(context).science;

        if(list.length == 0){
          return Center(child: CircularProgressIndicator(),);
        }else{
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>  buildArticlesItem(context, list[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: list.length,
          );
        }
      },
    );
  }
}

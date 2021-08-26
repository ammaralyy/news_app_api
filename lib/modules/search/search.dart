import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api/shared/components/components.dart';
import 'package:news_app_api/shared/cubit/cubit.dart';
import 'package:news_app_api/shared/cubit/states.dart';

class Search extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var list = AppCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Search',
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: customFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (value) {
                    AppCubit.get(context).getSearch(value);
                  },
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return "'search field mustn't be empty";
                    }
                    return null;
                  },
                  label: 'Search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(
                child: list.length == 0?
                Container():
                ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>  buildArticlesItem(context, list[index]),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: list.length,
                )
              ),
            ],
          ),
        );
      },
    );
  }
}

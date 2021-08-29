import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/shop_app/cubit/cubit.dart';
import 'package:task_todo/models/shop_app/home_model/home_model.dart';
import 'package:task_todo/models/shop_app/search_model/search_model.dart';
import 'package:task_todo/modules/shop_app/search/cubit/cubit.dart';
import 'package:task_todo/modules/shop_app/search/cubit/states.dart';
import 'package:task_todo/shared/components/component.dart';
import 'package:task_todo/shared/components/constants.dart';

class Search extends StatelessWidget {
  TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {

          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    DefaultTextFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'enter  text to search';
                          }
                          return null;
                        },
                        label: 'search',
                        prefix: Icons.search,
                        onSubmit: (String text) {
                          SearchCubit.get(context).search(text);
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchloadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => BuildSearchItems(SearchCubit.get(context).searchModel.data.data[index], context),
                          separatorBuilder: (context, index) => Divider(),
                          itemCount:SearchCubit.get(context).items),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }

  Widget BuildSearchItems(Product model, context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image),
                    width: 120,
                    // fit: BoxFit.cover,
                    height: 120,
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontSize: 14, height: 1.3),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text('${model.price}',
                              style:
                                  TextStyle(color: defaultColor, fontSize: 12)),
                          SizedBox(
                            width: 5,
                          ),
                          Spacer(),
                          IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color:
                                    ShopCubit.get(context).favorites[model.id]
                                        ? Colors.red
                                        : Colors.grey,
                              ),
                              onPressed: () {
                                ShopCubit.get(context)
                                    .changeFavorites(model.id);
                              })
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
/**/

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/shop_app/cubit/cubit.dart';
import 'package:task_todo/layout/shop_app/cubit/states.dart';
import 'package:task_todo/models/favorites/favorites.dart';
import 'package:task_todo/shared/components/constants.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder:(context)=> ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => BuildFavoriteItems(ShopCubit.get(context).favoritesModel.data.data[index],context),
              separatorBuilder: (context, index) => Divider(),
              itemCount: ShopCubit.get(context).favoritesModel.data.data.length),
        fallback: (context)=>CircularProgressIndicator(),
        );
      },
    );
  }

  Widget BuildFavoriteItems(FavoritesData model,context) => Padding(
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
                    image: NetworkImage(
                        model.product.image),
                    width: 120,
                   // fit: BoxFit.cover,
                    height: 120,
                  ),
                  if (model.product.discount != 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      color: Colors.red,
                      child:
                      Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  )
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
                        model.product.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontSize: 14, height: 1.3),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text('${model.product.price}',
                              style:
                                  TextStyle(color: defaultColor, fontSize: 12)),
                          SizedBox(
                            width: 5,
                          ),
                          if (model.product.discount != 0)
                            Text('${model.product.oldPrice}',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontSize: 10,
                                )),
                          Spacer(),
                          IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color:  ShopCubit.get(context).favorites[model.product.id]?Colors.red:Colors.grey,
                              ),
                              onPressed: () {
                                ShopCubit.get(context).changeFavorites(model.product.id);
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

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/shop_app/cubit/cubit.dart';
import 'package:task_todo/layout/shop_app/cubit/states.dart';
import 'package:task_todo/models/shop_app/categories_model/categories_model.dart';
import 'package:task_todo/models/shop_app/home_model/home_model.dart';
import 'package:task_todo/shared/components/component.dart';
import 'package:task_todo/shared/components/constants.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesState){
          if(!state.model.status){
            showToast(text: state.model.message, state: ToastState.ERROR);
          }
        }

      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) => ProductBuilder(ShopCubit.get(context).homeModel,
              ShopCubit.get(context).categoriesModel,context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget ProductBuilder(HomeModel model, CategoriesModel categoryModel,context) =>
      Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                  items: model.data.banners
                      .map((e) => Image(
                            width: double.infinity,
                            image: NetworkImage('${e.image}'),
                            fit: BoxFit.cover,
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: 250,
                    initialPage: 3,
                    autoPlay: true,
                    //  autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    // autoPlayInterval: Duration(seconds: 1),
                    enableInfiniteScroll: true,
                    reverse: false,
                    viewportFraction: 1.0,
                    scrollDirection: Axis.horizontal,
                  )),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      child: ListView.separated(
                        itemBuilder: (context, index) =>
                            BuildCategoryItems(categoryModel.data.data[index]),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 10,
                        ),
                        itemCount: categoryModel.data.data.length,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'New Products',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.grey[300],
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 1 / 1.68,
                  children: List.generate(model.data.products.length,
                      (index) => BuildProductIem(model.data.products[index],context)),
                ),
              ),
            ],
          ),
        ),
      );

  Widget BuildProductIem(ProductsModel model,context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  // fit: BoxFit.cover,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    color: Colors.red,
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            Padding(
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
                  Row(
                    children: [
                      Text('${model.price}',
                          style: TextStyle(color: defaultColor, fontSize: 12)),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text('${model.oldPrice}',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 10,
                            )),
                      Spacer(),
                      IconButton(
                          icon: Icon(Icons.favorite,color: ShopCubit.get(context).favorites[model.id]?Colors.red:Colors.grey,),
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(model.id);
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );

  Widget BuildCategoryItems(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
              width: 100,
              color: Colors.black.withOpacity(.6),
              child: Text(
                model.name,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ))
        ],
      );
}

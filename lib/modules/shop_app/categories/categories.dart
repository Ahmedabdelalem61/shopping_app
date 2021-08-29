import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/shop_app/cubit/cubit.dart';
import 'package:task_todo/layout/shop_app/cubit/states.dart';
import 'package:task_todo/models/shop_app/categories_model/categories_model.dart';

class Categories extends  StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(physics: BouncingScrollPhysics(),itemBuilder: (context,index)=>BuildCatItems(ShopCubit.get(context).categoriesModel.data.data[index]),
            separatorBuilder:(context,index)=> Divider(), itemCount: ShopCubit.get(context).categoriesModel.data.data.length);
      },
    );
  }
  Widget BuildCatItems(DataModel model){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image(image: NetworkImage(model.image),height: 80,width: 80,fit: BoxFit.cover,),
          SizedBox(width:10),
          Text(model.name),
          Spacer(),
          IconButton(icon: Icon(Icons.arrow_forward_ios),)

        ],
      ),
    );
  }
}

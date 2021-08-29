import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/shop_app/cubit/cubit.dart';
import 'package:task_todo/layout/shop_app/cubit/states.dart';
import 'package:task_todo/shared/components/component.dart';
import 'package:task_todo/shared/components/constants.dart';
import 'package:task_todo/shared/components/news_component.dart';

class Settings extends  StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(listener: (context,state){},
    builder: (context,state){
      name.text = ShopCubit.get(context).userData.data.name;
      email.text = ShopCubit.get(context).userData.data.email;
      phone.text = ShopCubit.get(context).userData.data.phone;
      String image = ShopCubit.get(context).userData.data.image;
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if(state is ShopLoadingUpdateUserDataState)
                LinearProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            image
                        ),
                      ),
                      Positioned(
                        top: 100,
                        right: 16,
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )
                    ] ,
                  ),
                ),
                DefaultTextFormField(controller: name, type: TextInputType.name, validate: (String value){
                  if(value.isEmpty){
                    return 'name must don\'t be empty';
                  }
                  return null;
                }, label: 'name', prefix: Icons.person),
                SizedBox(height: 20,),
                DefaultTextFormField(controller: email, type: TextInputType.emailAddress, validate: (String value){
                  if(value.isEmpty){
                    return 'email must don\'t be empty';
                  }
                  return null;
                }, label: 'Email', prefix: Icons.email_outlined),
                SizedBox(height: 20,),
                DefaultTextFormField(controller: phone, type: TextInputType.phone, validate: (String value){
                  if(value.isEmpty){
                    return 'phone must don\'t be empty';
                  }
                  return null;
                }, label: 'phone', prefix: Icons.phone),
                SizedBox(height: 20,),
                defaultButton(whenPress: (){
                  if(formKey.currentState.validate()){
                    ShopCubit.get(context).updateUserData(name: name.text, email: email.text, phone: phone.text);
                  }

                }, text: 'UPDATE'),
                SizedBox(height: 20,),
                defaultButton(whenPress: (){
                  signOut(context);
                }, text: 'LOGOUT')
              ],
            ),
          ),
        ),
      );
    },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_todo/shared/cubit/cubit.dart';

Widget DefaultTextFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool ispassword = false,
  @required validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: ispassword,
    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    validator: validate,
    onTap: onTap,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null ? IconButton(icon: Icon(suffix), onPressed: suffixPressed) : null,
      border: OutlineInputBorder(),
    ),
  );
}

Widget WidgetBuildTaskItem(Map model, context) => Dismissible(
  key: Key('model[id]'),
  onDismissed: (direction){
   AppCubit.get(context).deleteFromDataBase(id: model['id']);
  },
  child:   Padding(

        padding: const EdgeInsets.only(left: 15, right: 0, top: 5, bottom: 5),

        child: Row(

          children: [

            CircleAvatar(

              radius: 40,

              child: Text(

                '${model['time']}',

                style: TextStyle(

                  fontSize: 15,

                  fontWeight: FontWeight.bold,

                ),

              ),

            ),

            SizedBox(

              width: 15,

            ),

            Expanded(

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisSize: MainAxisSize.min,

                children: [

                  Text(

                    '${model['title']}',

                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

                  ),

                  Text(

                    '${model['date']}',

                    style: TextStyle(fontSize: 15, color: Colors.grey),

                  )

                ],

              ),

            ),

            SizedBox(

              width: 15,

            ),

            IconButton(

                icon: Icon(

                  Icons.check_box,

                  color: Colors.amberAccent,

                ),

                onPressed: () => AppCubit.get(context)

                    .updateDateBase(status: 'done', id: model['id'])),

            IconButton(

                icon: Icon(

                  Icons.archive_outlined,

                  color: Colors.grey,

                ),

                onPressed: () => AppCubit.get(context)

                    .updateDateBase(status: 'archive', id: model['id'])),

          ],

        ),

      ),
);

void showToast(
{
  @required String text,
  @required ToastState state
}
)=>Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: toastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToastState{SUCCESS,ERROR,WARNING}
Color toastColor(ToastState state){
  Color color;
  switch(state){
    case ToastState.SUCCESS :
      color = Colors.green;
      break;
    case ToastState.WARNING :
      color = Colors.amber;
      break;
    case ToastState.ERROR :
      color = Colors.red;
      break;
  }
  return color;
}
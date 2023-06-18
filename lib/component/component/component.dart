import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  IconData ?suffixIcon,
  bool isPass=false,
  Function()? showPass,
  Function()? onTab,

  required String label,
  required IconData prefixIcon,
  required String kind,
  Function(String value)? onChange,
  context,
  Function(String  value)? onSubmit

}) {
  return TextFormField(
    controller: controller,
    onTap: onTab,
    onFieldSubmitted: onSubmit,
    keyboardType: type,
    obscureText: isPass,

    onChanged: onChange,
    validator: (String? value) {
      if (value!.isEmpty) {
        return '$kind must not be Empty';
      }
      return null;
    },


    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      prefixIcon: Icon(prefixIcon),
      suffixIcon: IconButton(onPressed: showPass, icon: Icon(suffixIcon),),
      labelStyle: TextStyle(
          color: Colors.grey
      ),
      prefixStyle: TextStyle(
          backgroundColor: Colors.white
      ),



    ),
  );
}


Widget defaultButton({
  @required double width =double.infinity,
  @required Color background=Colors.blue,
  // required  Function() function,
  required String text,
  required Null Function() onpressed,
}) {
  return Container(
    width: width,
    height: 40,
    color: background,
    child: MaterialButton(

      onPressed: onpressed,
      child: Text('${text.toUpperCase()}',
        style: TextStyle(
            fontSize: 20,
            color: Colors.white
        ),
      ),
    ),

  );
}


Widget defaultTextButton({
  required Function() function,
  required String text
}){
  return TextButton(onPressed: function, child:Text(
      '${text}'
  ),
  );
}

Widget MyDivider(){
  return Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  );
}

void showToast({
  required String msg,
  required ToastStatus state
}){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastStatus{SUCCESS, ERROR, WARNING}

Color? chooseToastColor(ToastStatus state){
  Color color;
  switch(state)
  {
    case ToastStatus.SUCCESS:
      color= Colors.green;
      break;
    case ToastStatus.WARNING:
      color= Colors.amber;
      break;
    case ToastStatus.ERROR:
      color= Colors.red;
      break;
  }
  return color;
}


void navigateTo(context,widget){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}

void navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>widget),
        (route) => false
);


Widget defaultAppBar({
  required BuildContext context,
  String? text,
  List<Widget>? actions,
}){
  return AppBar(
    leading:IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: (){
        Navigator.pop(context);
      },
    ) ,
    title: Text(
      '${text}'
    ),
    titleSpacing: 3,
    actions: actions,
  );
}
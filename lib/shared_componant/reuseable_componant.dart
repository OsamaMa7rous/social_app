import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/styles/icon_broken.dart';

void navigateTo(BuildContext context ,Widget builder ){
  Navigator.push(context, MaterialPageRoute(builder:(context) => builder, ));
}
void navigateAndFinish(BuildContext context ,Widget builder ){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => builder,), (route) => false);
}
Widget defaultTextFormFiled({
  required TextEditingController controller,
  required TextInputType type,
  required FormFieldValidator<String> validator,
  required IconData prefix,
  required String label,
  ValueChanged<String>? onSubmitted,
  IconData? suffix,
  bool isClickable = true,
  bool obscure = false,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
  ValueChanged<String>? onChange
}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        obscureText: obscure,
        validator: validator,
        enabled: isClickable,
        onFieldSubmitted: onSubmitted,
        onTap: onTap,
        onChanged: onChange,
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(

          decoration: TextDecoration.none,

        ),
        decoration: InputDecoration(

          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(
            onPressed: suffixPressed,
            icon: Icon(suffix),
          )
              : null,
          label: Text(label),
          border: const OutlineInputBorder(),
        ),

      ),
    );

Future<bool?> showToast({required String massage}){
  return Fluttertoast.showToast(
      msg: massage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
void printFullText({required String text}){
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) { print(match.group(0));});
}

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  List<Widget>? actions ,
    String title='',})=>AppBar(
  leading: IconButton(onPressed: (){
    Navigator.pop(context);
  }, icon: const Icon(IconBroken.Arrow___Left_2)),
  title: Text(title),
  actions: actions,
);
Widget defaultBottom(
    {required BuildContext context, required String text,required VoidCallback? onPressed})=>   Container(
  width: double.infinity,
  height: 40.0,
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(5.0),
  ),
  child: MaterialButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white,fontSize: 14),
    ),
  ),
);



Widget separatorBuilder(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 1,
      color: Colors.grey[500],
    ),
  );
}




Future<Widget> alertLogOutFunc(
    {required BuildContext context, required Size size,required String info}) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            info,
            style: TextStyle(color: Colors.grey, fontSize: size.height * .03),
          ),
          actions: [

            const SizedBox(),
            MaterialButton(
              onPressed: ()  {
              Navigator.pop(context);
              },
              textColor: Colors.white,
              color: Colors.blue,
              child: const Text("ok"),
            ),
          ],
        );
      }).catchError((error) {
    throw error;
  });
}
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit/cubit.dart';
import 'package:social_app/cubit/social_cubit/states.dart';

import 'package:social_app/modules/login_screen.dart';
import 'package:social_app/remote/dio_helper.dart';
import 'package:social_app/shared_componant/constant.dart';
import 'package:social_app/shared_componant/cubit_observe/observable.dart';
import 'package:social_app/styles/themes.dart';

import 'layout/social_layout.dart';
import 'local/cache_helper.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  CacheHelper.init();
  await Firebase.initializeApp();
  var token =await FirebaseMessaging.instance.getToken();
  print(token);

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  }); FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });
  Future<void> backgroundMessageHandler(RemoteMessage message)async {
    FirebaseMessaging.onMessage.listen((event) {
      print(event.data.toString());
    });
  }
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  Widget widget;

   uId = CacheHelper.getData(key: "uId");
 print(uId);
  if(uId != null){
    widget= const SocialLayout();

  } else{
    widget= SocialLoginScreen();
  }
 await CacheHelper.init();
  BlocOverrides.runZoned(
        () {
          runApp( MyApp(widget: widget,));
        },
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget {
final Widget widget;
   const MyApp({Key? key, required this.widget,}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()..getUserData()..getPosts()..getAllUsers(),
      child: BlocConsumer<SocialCubit,SocialCubitStates>(
        listener: (context, state) {

        },
        builder: (context, state) =>MaterialApp(
          title: 'Flutter Demo',
          theme: lightTheme,
          themeMode: ThemeMode.light,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          home:  widget,
        ) ,

      ),
    );
  }
}

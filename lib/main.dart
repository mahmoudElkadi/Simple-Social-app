import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Network/local/sharedPrefernce.dart';
import 'package:social_app/component/component/component.dart';
import 'package:social_app/component/cubit/Cubit.dart';
import 'package:social_app/component/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'component/constant/constants.dart';
import 'component/cubit/bloc_observer.dart';
import 'component/cubit/socialLoginCubit.dart';
import 'layout/sociallayout.dart';
import 'modules/login/loginScreen.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message)async{
print(message.data.toString());
print('on background message');
showToast(msg: 'on background message', state:ToastStatus.SUCCESS );

}

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer=MyBlocObserver();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAyTpevjsjmO1Wl7oGdmo4QWWX-gxdTmAQ",
      appId: "1:585454198693:android:3fcd9ecae61f515b65524c",
      messagingSenderId: "585454198693",
      projectId: "social-app-38784",
    ),
  );

  var token=await FirebaseMessaging.instance.getToken();

  print(token);

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());

    showToast(msg: 'on message', state:ToastStatus.SUCCESS );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(msg: 'on message Opened app', state:ToastStatus.SUCCESS );
  });
  
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CacheHelper.init();

  uId=CacheHelper.getData(key: 'uId');

  Widget startWidget;

  if(uId == null){
    startWidget=LoginScreen();
  }else{
    startWidget=SocialHomeScreen();
  }

  runApp( MyApp(widget:startWidget));
}


class MyApp extends StatelessWidget {
  final Widget widget;
  MyApp({
    required this.widget
});
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize Firebase:
      future: _initialization,
      builder: (context, snapshot) {
        //if (snapshot.connectionState == ConnectionState.done)
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (BuildContext context)=>SocialLoginCubit()),
              BlocProvider(create: (BuildContext context)=>SocialCubit()..getUserData()..getAllPosts()),
            ],
            child: BlocConsumer<SocialLoginCubit,SocialLoginState>(
              listener: (context,state){},
              builder: (context,state){
                return MaterialApp(
                  title: 'Flutter Demo',
                  debugShowCheckedModeBanner: false,
                  theme:ThemeData(

                    primarySwatch: defaultColor,
                    scaffoldBackgroundColor: Colors.white,
                    appBarTheme: AppBarTheme(
                        titleSpacing: 20,
                        iconTheme: IconThemeData(
                            color: Colors.black
                        ),
                        backgroundColor: Colors.white10,
                        elevation: 0,
                        systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarColor: Colors.white10,
                            statusBarBrightness: Brightness.dark
                        ),
                        titleTextStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                        type: BottomNavigationBarType.fixed,
                        selectedItemColor: defaultColor,
                        elevation:20,
                        backgroundColor: Colors.white


                    ),
                    textTheme: TextTheme(

                      bodyText1: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    fontFamily: 'Jannah',



                  ),
                  home: widget,
                );
              },
            ),
          );

      },
    );
  }
}








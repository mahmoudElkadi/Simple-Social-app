import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component/component/component.dart';
import 'package:social_app/component/cubit/Cubit.dart';
import 'package:social_app/component/cubit/states.dart';
import 'package:social_app/modules/NewPost/newPost.dart';

class SocialHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){
          if(state is NewPostSuccussStates){
            navigateTo(context, NewPostScreen());
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text(SocialCubit.get(context).title[SocialCubit.get(context).index1],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),
              actions: [

                Icon(Icons.notification_add_outlined),
                SizedBox(width: 15,),
                Icon(Icons.search),
                SizedBox(width: 10,),

              ],
            ),
            body: SocialCubit.get(context).screen[SocialCubit.get(context).index1],
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.cyan,
              unselectedItemColor: Colors.grey,
              selectedIconTheme:IconThemeData(
                color: Colors.cyan
              ) ,
              unselectedIconTheme: IconThemeData(
                color: Colors.grey
              ),
              currentIndex:SocialCubit.get(context).index1 ,
              onTap: (index){
                SocialCubit.get(context).changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home',),
                BottomNavigationBarItem(icon: Icon(Icons.chat,),label: 'Chat'),
                BottomNavigationBarItem(icon: Icon(Icons.add,),label: 'Post'),
                BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Users'),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Setting'),
              ],
            ),
          );
        },
      );
  }
}

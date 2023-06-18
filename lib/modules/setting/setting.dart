import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component/component/component.dart';
import 'package:social_app/component/cubit/Cubit.dart';
import 'package:social_app/component/cubit/states.dart';

import '../EditProfile/editProfile.dart';

class SettingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return  BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){
        },
        builder: (context,state){
          var cubit=SocialCubit.get(context).users;

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 212,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,

                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('${cubit?.cover}'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight:Radius.circular(5)
                              )
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 68,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 65,
                          backgroundImage: NetworkImage('${cubit?.image}'),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 5,),
                Text('${cubit?.name}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 5,),
                Text('${cubit?.bio}' ,
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text('100',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(height: 5,),
                              Text('Posts',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text('265',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(height: 5,),
                              Text('Photos',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text('5K',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(height: 5,),
                              Text('Followers',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text('10K',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(height: 5,),
                              Text('Following',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: OutlinedButton(
                      onPressed: (){

                      },
                      child: Text('Add Photos'),
                    )),
                    SizedBox(width: 10,),
                    OutlinedButton(
                      onPressed: (){
                        navigateTo(context, EditProfileScreen());
                      },
                      child: Icon(Icons.edit),
                    )
                  ],
                ),
                Row(
                  children: [
                    OutlinedButton(onPressed:(){
                      FirebaseMessaging.instance.subscribeToTopic('announcements');
                    }, child: Text('Subscribe')),
                    SizedBox(width: 15,),
                    OutlinedButton(onPressed:(){
                      FirebaseMessaging.instance.unsubscribeFromTopic('announcements');

                    }, child: Text('UnSubscribe')),
                  ],
                )

              ],
            ),
          );
        },

    );
  }
}

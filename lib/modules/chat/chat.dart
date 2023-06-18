import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component/cubit/Cubit.dart';
import 'package:social_app/models/users.dart';
import 'package:social_app/modules/chat/chatDetilsScreen.dart';

import '../../component/component/component.dart';
import '../../component/cubit/states.dart';

class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
            body:SingleChildScrollView(
              child: ConditionalBuilder(
                condition:SocialCubit.get(context).allUser.length > 0 ,
                builder:(context)=> ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder:(context,index)=> buildChatList(SocialCubit.get(context).allUser[index],context),
                    separatorBuilder:(context,index)=>MyDivider() ,
                    itemCount: SocialCubit.get(context).allUser.length
                ),
                fallback: (context)=>Center(child: CircularProgressIndicator(),),

              ),
            )
        );
      },
    );
  }

  Widget buildChatList(UsersModel model,context)=>InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(model));
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 70,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage('${model.image}') ,
              ),
              SizedBox(width: 15,),

              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${model.name}',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),

            ]
        ),
      ),
    ),
  );

}







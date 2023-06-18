import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component/constant/constants.dart';
import 'package:social_app/component/cubit/Cubit.dart';
import 'package:social_app/component/cubit/states.dart';
import 'package:social_app/models/chat.dart';
import 'package:social_app/models/users.dart';

class ChatDetailsScreen extends StatelessWidget {
  UsersModel? usersModel;
  ChatDetailsScreen(this.usersModel);
  var messageController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context){
        SocialCubit.get(context).getMessages(recevierId: usersModel!.uId!);

        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('${usersModel?.image}'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('${usersModel?.name}'),
                  ],
                ),
              ),
              body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ConditionalBuilder(
                        condition: SocialCubit.get(context).message.length >0,
                        builder: (context)=>Expanded(
                          child: ListView.separated(
                              itemBuilder: (context,index){
                                var message=SocialCubit.get(context).message[index];
                                if(SocialCubit.get(context).uid ==message.senderId){
                                  return buildMyMessage(message);
                                }
                                else{
                                  return buildMessage(message);
                                }
                              },
                              separatorBuilder: (context,index)=>
                                SizedBox(height: 15,)
                              ,
                              itemCount: SocialCubit.get(context).message.length),
                        ),
                        fallback: (context)=>Center(child: CircularProgressIndicator(),),
                      ),

                      Container(

                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color:Colors.grey.withOpacity(0.5),
                              width:1,
                            ),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type your massage here ...'
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 48,
                              color: defaultColor,
                              child: MaterialButton(onPressed: (){
                                SocialCubit.get(context).sendMessage(
                                    receiverId: usersModel!.uId!,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text);
                                messageController.text='';
                              },
                                minWidth: 1,
                                child: Icon(Icons.send,
                                  size: 17,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(ChatModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding:EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          )
      ),
      child: Text(
          '${model.text}'
      ),
    ),
  );
  Widget buildMyMessage(ChatModel model)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding:EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      decoration: BoxDecoration(
          color: defaultColor.withOpacity(0.2),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          )
      ),
      child: Text(
          '${model.text}'
      ),
    ),
  );
}

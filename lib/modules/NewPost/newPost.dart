import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component/component/component.dart';
import 'package:social_app/component/cubit/Cubit.dart';
import 'package:social_app/component/cubit/states.dart';

import '../../layout/sociallayout.dart';

class NewPostScreen extends StatelessWidget  {
  var textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var postImage=SocialCubit.get(context).postImage ;

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: defaultAppBar(context: context,
                text: "Create Post",
                actions: [
                  defaultTextButton(function:(){
                    var now=DateTime.now();

                    if (SocialCubit.get(context).postImage==null)
                      {
                        SocialCubit.get(context).posts =[];
                        var now=DateTime.now();
                       SocialCubit.get(context).createPost(date: now.toString(), text: textController.text,);

                      }else{
                      SocialCubit.get(context).posts =[];

                      SocialCubit.get(context).UploadPostImage(date: now.toString(), text: textController.text);
                      navigateTo(context, SocialHomeScreen());

                    }

                  }, text: 'post')
                ]
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                children: [
                  if(state is SocialCreatePostLoadingStates)
                  LinearProgressIndicator(),
                  SizedBox(height: 10,),
                  Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage('${SocialCubit.get(context).users?.image}') ,
                        ),
                        SizedBox(width: 15 ,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [

                                  Text('${SocialCubit.get(context).users?.name}',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ]
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'what is in your mind ...',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  if (postImage!=null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [

                      Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image:postImage!=null? FileImage(postImage!) as ImageProvider:NetworkImage(''),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      IconButton(onPressed: (){
                        SocialCubit.get(context).removePostImage();
                      }, icon: CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.close))),

                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: (){
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image),
                              SizedBox(width: 5,),
                              Text('Add Phote')
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: TextButton(onPressed: () {  },
                        child: Text('# tags'),

                      ))
                    ],
                  )
                ]
            ),
          ),
        );
      },

    );
}


}

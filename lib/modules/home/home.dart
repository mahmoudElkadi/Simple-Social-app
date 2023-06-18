import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component/component/component.dart';
import 'package:social_app/component/cubit/Cubit.dart';
import 'package:social_app/component/cubit/states.dart';

import '../../models/post.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
            condition: SocialCubit.get(context).posts.length >0 && SocialCubit.get(context).postId.length >0,
            builder: (context)=>SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200]
                ),
                child: Column(
                  children: [
                    Container(
                      child: Card(
                        margin: EdgeInsets.all(10),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child:Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children :[
                              Image(
                                image: NetworkImage(
                                    'https://img.freepik.com/free-photo/portrait-attractive-pleased-woman-looks-gladfully-aside_273609-40233.jpg?w=1380&t=st=1685526139~exp=1685526739~hmac=6dd5ca5d46e7b6caa7488e6869d6fb17123916325fb4f43ded464bb3fc5aca97'),
                                height: 200,
                                width: double.infinity,

                                fit: BoxFit.cover,
                              ),
                              Text('Communicate with friends',
                                style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white),)
                            ]
                        ),

                      ),
                    ),
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return buildPostItem(SocialCubit.get(context).posts[index],context,index);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 10,);
                      },
                      itemCount: SocialCubit.get(context).posts.length,),


                  ],
                ),
              ),
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()));
      },

    );
  }

  Widget buildPostItem(PostModel model,context,index)=>Card(
    margin: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage('${model.image}') ,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('${model.name}',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                      ),
                      SizedBox(width: 4,),
                      Icon(Icons.check_circle,
                        color: Colors.blue,
                        size: 16,
                      )
                    ],
                  ),
                  Text('${model.date}',
                    style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 14,
                        height: 1.4),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10,),
            IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            color: Colors.grey[300],
            height: 1,
            width: double.infinity,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text("${model.text}",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500,fontSize: 14,height: 1.3),),
        ),
        // Padding(
        //
        //   padding: const EdgeInsets.symmetric(vertical: 10),
        //   child: Container(
        //     width: double.infinity,
        //
        //     child: Wrap(
        //       children: [
        //
        //       Container(
        //         height: 25,
        //         child: MaterialButton(
        //           minWidth: 1,
        //           padding: EdgeInsets.zero,
        //
        //           onPressed: (){},
        //           child: Text('#flutter_software_devoloper',style: TextStyle(color: Colors.blue),),),
        //       ),
        //
        //       ],
        //     ),
        //   ),
        // ),
        if(model.postImage!='')
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('${model.postImage}'),
                  fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(5)
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          child: Row(
            children: [
              Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Icon(Icons.favorite_border,color: Colors.red,),
                          SizedBox(width: 5,),

                          Text( SocialCubit.get(context).posts[index].likes?.length == null ? '0' : '${SocialCubit.get(context).posts[index].likes?.length}'),
                        ],
                      ),
                    ),
                  )),
              Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.chat,color: Colors.amber,size: 16,),
                          SizedBox(width: 5,),
                          Text('0 comments'),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            color: Colors.grey[300],
            height: 1,
            width: double.infinity,
          ),
        ),


        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage("${SocialCubit.get(context).users?.image}"),
                    ),
                    SizedBox(width: 8,),
                    InkWell(
                      onTap: (){},
                      child: Text('write the comment ... ',
                        style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 14,
                            height: 1.4),
                      ),
                    ),

                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  SocialCubit.get(context).likePost2(SocialCubit.get(context).postId[index]);


                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Icon(Icons.favorite_border,color: Colors.red,),
                      SizedBox(width: 5,),
                      Text('Like'),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Icon(Icons.share,color: Colors.amber,),
                      SizedBox(width: 5,),
                      Text('share'),
                    ],
                  ),
                ),
              )
            ],
          ),
        )

      ],
    ),

  );
}

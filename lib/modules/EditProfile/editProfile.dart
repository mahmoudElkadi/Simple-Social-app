import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component/cubit/Cubit.dart';
import 'package:social_app/component/cubit/states.dart';

import '../../component/component/component.dart';
import '../setting/setting.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController=TextEditingController();
  var bioController=TextEditingController();
  var phoneController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var users=SocialCubit.get(context).users;
        var cubit=SocialCubit.get(context);
        var profileImage=SocialCubit.get(context).profileImage ;
        var coverImage=SocialCubit.get(context).coverImage  ;
        if (users !=null)
        {
          nameController.text = cubit.users!.name!;
          bioController.text = cubit.users!.bio!;
          phoneController.text = cubit.users!.phone!;
        }

        return Scaffold(
          appBar: AppBar(
            title:Text('Edit Profile'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if(state is SocialUpdateUserLoadingStates)
                LinearProgressIndicator(),
                if(state is SocialUpdateUserLoadingStates)
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
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
                                      image:coverImage == null ? NetworkImage('${cubit.users?.cover}'):FileImage(coverImage) as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight:Radius.circular(5)
                                    )
                                ),
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 68,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 65,
                                    backgroundImage:profileImage ==null? NetworkImage('${cubit.users?.image}') : FileImage(profileImage) as ImageProvider,
                                  ),
                                ),
                                IconButton(onPressed: (){
                                  SocialCubit.get(context).getImage();
                                }, icon: CircleAvatar(
                                    radius: 20,
                                    child: Icon(Icons.camera_alt_outlined))),
                              ],
                            ),

                          ],
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: IconButton(onPressed: (){
                          SocialCubit.get(context).getCoverImage();
                        }, icon: CircleAvatar(
                            radius: 20,
                            child: Icon(Icons.camera_alt_outlined))),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      if(SocialCubit.get(context).profileImage!=null)
                      Expanded
                        (
                        child: Column(
                          children: [
                            defaultButton( text: 'upload image', onpressed: (){
                              SocialCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                                  }),
                            if(state is SocialUploadImageProfileLoadingStates)
                            LinearProgressIndicator()
                          ],
                        ),

                      ),
                      SizedBox(width: 8,),
                      if(SocialCubit.get(context).coverImage!=null)
                      Expanded(
                          child: Column(
                            children: [
                              defaultButton( text: 'upload cover', onpressed: (){
                                SocialCubit.get(context).uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);

                              }),
                              if(state is SocialUploadImageCoverLoadingStates)
                              LinearProgressIndicator()
                            ],
                          )),
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: defaultTextFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      label: 'UserName',
                      prefixIcon: Icons.person,
                      kind: 'Username'
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: defaultTextFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      label: 'Bio',
                      prefixIcon: Icons.text_rotate_up,
                      kind: 'Bio'
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: defaultTextFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      label: 'Phone',
                      prefixIcon: Icons.phone,
                      kind: 'Phone'
                  ),
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}

//
//
// PreferredSize(
// preferredSize: const Size.fromHeight(60),
// child: defaultAppBar(context: context,
// text: "Edit Profile",
// actions: [
//
// defaultTextButton(function: (){
//
// cubit.updateUserData(name: nameController.text, phone: phoneController.text, bio: bioController.text);
// }, text: 'Update'),
// SizedBox(width: 10,)
// ]
// ),
// ),
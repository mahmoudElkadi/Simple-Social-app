import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/component/cubit/states.dart';
import 'package:social_app/models/chat.dart';
import '../../Network/local/sharedPrefernce.dart';
import '../../layout/sociallayout.dart';
import '../../models/post.dart';
import '../../models/users.dart';
import '../../modules/chat/chat.dart';
import '../../modules/home/home.dart';
import '../../modules/setting/setting.dart';
import '../../modules/users/users.dart';
import '../component/component.dart';
import '../constant/constants.dart';


class SocialCubit extends Cubit<SocialStates>{
  SocialCubit():super(SocialInitStates());
  static SocialCubit get(context)=>BlocProvider.of(context);

  UsersModel? users;

 var uid=CacheHelper.getData(key: 'uId');

  void getUserData()async{
    print(uid);
    emit(SocialGetUserLoadingStates());
   await FirebaseFirestore.instance.collection('users').doc(uid).get().then((DocumentSnapshot doc) {
      users=UsersModel.fromJson(doc.data() as Map<String, dynamic>);
      emit(SocialGetUserSuccessStates());
    }).catchError((error){
      print('err'+error.toString());
    });
  }

  List<UsersModel> allUser=[];

  void getAllUsers(){
    allUser=[];
    emit(SocialGetAllUserLoadingStates());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element){
        if(element.data()['uId'] != uid) {
          allUser.add(UsersModel.fromJson(element.data()));
          print(allUser);
        }
      });
      emit(SocialGetAllUserSuccessStates());
    });
  }

  List<Widget> screen=[
    HomeScreen(),
    ChatScreen(),
    HomeScreen(),
    UserScreen(),
    SettingScreen()
  ];

  List<String> title=[
    "Home","Chat",'Post',"Users","Settings"
  ];

  int index1=0;

  void changeIndex(index){

    if (index==1){
      getAllUsers();
    }

    if (index==2){
      emit(NewPostSuccussStates());
    }else{
      index1=index;
      emit(ChangeIndexSuccussStates());
    }


  }


  File? profileImage;
  final picker = ImagePicker();

  Future getImage()async{
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage !=null){
      profileImage=File(pickedImage.path);
      emit(SocialProfileImageSuccussStates());
    }else{
      print('No image selected');
      emit(SocialProfileImageErrorStates());
    }

  }



  File? coverImage;
  final pickerCover = ImagePicker();

  Future getCoverImage()async{
    XFile? pickedImage = await pickerCover.pickImage(source: ImageSource.gallery);

    if (pickedImage !=null){
      coverImage=File(pickedImage.path);
      emit(SocialCoverImageSuccussStates());
    }else{
      print('No image selected');
      emit(SocialCoverImageErrorStates());
    }

  }

  File? postImage;
  final pickerPost = ImagePicker();

  Future getPostImage()async{
    XFile? pickedImage = await pickerPost.pickImage(source: ImageSource.gallery);

    if (pickedImage !=null){
      postImage=File(pickedImage.path);
      emit(SocialPostImageSuccussStates());
    }else{
      print('No image selected');
      emit(SocialPostImageErrorStates());
    }

  }



  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
}){

    emit(SocialUploadImageProfileLoadingStates());
    firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file( profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value){
          value.ref.getDownloadURL().then((value){
            updateUserData(name: name, phone: phone, bio: bio,image: value);
          }).catchError((err){
            emit(SocialUploadImageProfileErrorStates());
          });
    })
    .catchError((err){
      emit(SocialUploadImageProfileErrorStates());
    })
    ;
  }



  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
}){
    emit(SocialUploadImageCoverLoadingStates());

    firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file( coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value){
      value.ref.getDownloadURL().then((value){
        updateUserData(name: name, phone: phone, bio: bio,cover: value);
      }).catchError((err){
        emit(SocialUploadImageCoverErrorStates());
      });
    })
        .catchError((err){
      emit(SocialUploadImageCoverErrorStates());
    })
    ;
  }


  void UploadPostImage({
    required String date,
    required String text,
  }){
    emit(SocialCreatePostLoadingStates());

    firebase_storage.FirebaseStorage.instance.ref()
        .child('posts/${Uri.file( postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value){
      value.ref.getDownloadURL().then((value){
        print(value);
        createPost(date: date, text: text, postImage: value);
        emit(SocialCreatePostSuccussStates());

      }).catchError((err){
        emit(SocialCoverImageErrorStates());
      });
    })
        .catchError((err){
      emit(SocialCreatePostErrorStates());
    })
    ;
  }

  Future<void> createPost({
    required String date,
    required String text,
    String? postImage,
    List? likes,
    context
  })async {
    {
      emit(SocialCreatePostLoadingStates());

      PostModel postModel = PostModel(
          name: users?.name,
          uId: uid,
          image: users?.image,
          text:text,
          postImage: postImage??'',
          date: date,

      );

     await FirebaseFirestore.instance.collection('posts').add(postModel.toMap()).then((value) {
        emit(SocialCreatePostSuccussStates());
      }).then(
          (value){
            getAllPosts();
          }
      ).then((value){

     })
         .catchError((err) {
        print(err.toString());
        emit(SocialCreatePostErrorStates());
      });
    }
  }

  void removePostImage(){
    postImage = null;
    emit(SocialRemovePostImageSuccussStates());
  }


  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image
  }){
    {
      UsersModel userModel = UsersModel(
          name: name,
          phone: phone,
          uId: uId,
          bio: bio,
          email: users?.email,
          cover:cover?? users?.cover,
          image:image?? users?.image


      );

      FirebaseFirestore.instance.collection('users').doc(uid).update(
          userModel.toMap()
      ).then((value) {
        getUserData();
      }).catchError((err) {
        print(err.toString());
        emit(SocialUpdateUserErrorStates());
      });
    }
  }

  List<PostModel> posts=[];
  List<String> postId=[];
  List<int> likes=[];

  void getAllPosts(){
    emit(SocialGetPostsLoadingStates());
    FirebaseFirestore.instance.collection('posts').orderBy('date',descending: true).get().then((value) {

      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value){
          likes.add(value.docs.length);
          print(likes);
        }).then((value){
          emit(SocialLikePostSuccussStates());
        });

        postId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));
      });

      emit(SocialGetPostsSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(SocialGetPostsErrorStates());
    });
  }

void likePost(String postId){
FirebaseFirestore.instance.collection('posts').doc(postId)
    .collection('likes').doc(users?.uId).set({
  'likes':true,
})
    .then((value){
      posts=[];
      emit(SocialLikePostSuccussStates());
})
    .catchError((error){

      emit(SocialLikePostErrorStates());
});
}

void likePost2(postId){
  FirebaseFirestore.instance.collection('posts').doc(postId).update(
  {'likes':FieldValue.arrayUnion([uid])}

  ).then((value){
    posts=[];

    emit(SocialLikePostSuccussStates());
  }).then((value) {
    getAllPosts();
  });
}

PostModel? postModel;

  void getPostData(postId)async{
    emit(SocialGetOnePostLoadingStates());
    await FirebaseFirestore.instance.collection('posts').doc(postId).get().then((DocumentSnapshot doc) {
      postModel=PostModel.fromJson(doc.data() as Map<String, dynamic>);
      emit(SocialGetOnePostSuccessStates());
    }).catchError((error){
      print('err'+error.toString());
    });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
}){
    ChatModel model=ChatModel(
      text: text,
      senderId: uid,
      dateTime:dateTime,
      receiverId: receiverId
    );
    FirebaseFirestore.instance.collection('users')
        .doc(uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
          emit(SocialSendMessageSuccussStates());
    }).catchError((error){
          emit(SocialSendMessageErrorStates());
    });

    FirebaseFirestore.instance.collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uid)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccussStates());
    }).catchError((error){
      emit(SocialSendMessageErrorStates());
    });

  }

  List<ChatModel> message=[];

  void getMessages({
required String recevierId
}){
    FirebaseFirestore.instance.collection('users')
    .doc(uid)
    .collection('chats')
    .doc(recevierId)
    .collection('messages').orderBy('dateTime',descending: false)
    .snapshots().listen((event) {
      message=[];
      event.docs.forEach((element) {
        message.add(ChatModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccussStates());
    });
}

}
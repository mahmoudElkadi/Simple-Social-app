
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component/cubit/states.dart';
import 'package:social_app/models/users.dart';


class SocialLoginCubit extends Cubit<SocialLoginState> {
  SocialLoginCubit() :super(SocialLoginInitState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);


  void userLogin({
    required String email,
    required String password
  }){
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password).then((value) {
          print(value.user?.email);
          emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(SocialLoginErrorState(error.toString()));
    });
  }


  void registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,

  }){
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value) {
          print(value.user?.email);
          print(value.user?.uid);

          createUser(
            name: name,
            email: email,
            phone: phone,
            uId: value.user!.uid,

          );
    });



  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,

  }){
    emit(SocialCreateLoadingState());
    UsersModel users=UsersModel  (
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      cover:'https://img.freepik.com/free-photo/group-friends-jumping-top-hill_273609-15304.jpg?size=626&ext=jpg&ga=GA1.1.762733781.1685526094',
      image: 'https://img.freepik.com/free-photo/vertical-shot-handsome-pensive-unshaven-young-male-keeps-hands-pressed-together-looks-pensively-upwards-dressed-elegant-denim-shirt-isolated-pink-wall-with-copy-space-aside_273609-15897.jpg?size=626&ext=jpg&ga=GA1.2.762733781.1685526094',
      bio: 'Write your bio...',
      isEmailVerified:false,
    );


    FirebaseFirestore.instance.collection('users').doc(uId).set(users.toMap()).then((value) {
      emit(SocialCreateSuccessState());
    }).catchError((error){
emit(SocialCreateErrorState(error.toString()));
    });

  }







  // SocialRegisterModel? updateProfileModel;
  //
  // void updateProfile({
  //   required String name,
  //   required String phone,
  //   required String email,
  // }){
  //   emit(SocialUpdateLoadingState());
  //   DioHelper.putData(
  //       url: UPDATEPROFILE,
  //       token: token,
  //       data: {
  //         "name": name,
  //         "email": email,
  //         "phone": phone,
  //       }
  //   ).then((value) {
  //     updateProfileModel=SocialRegisterModel.fromJson(value.data);
  //     print(updateProfileModel?.message);
  //     emit(SocialUpdateSuccessState());
  //   });
  // }
  //


  IconData suffix = Icons.remove_red_eye;
  bool obscureText = true;

  void changePasswordVisibility() {
    obscureText = !obscureText;

    suffix = obscureText ? Icons.remove_red_eye : Icons.visibility_off;

    emit(SocialShowPasswordState());
  }


}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/component/component.dart';
import '../../component/cubit/socialLoginCubit.dart';
import '../../component/cubit/states.dart';
import '../../layout/sociallayout.dart';

class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var nameController=TextEditingController();
    var emailController=TextEditingController();
    var phoneController=TextEditingController();
    var passwordController=TextEditingController();

    final GlobalKey<FormState> formKey=GlobalKey<FormState>();

    return BlocConsumer<SocialLoginCubit,SocialLoginState>(
        listener: (context,state){
          if(state is SocialCreateSuccessState){
            navigateAndFinish(context, SocialHomeScreen());
            showToast(msg: 'Register is Successfully',
                state: ToastStatus.SUCCESS);
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black
                        ),
                      ),
                      Text(
                        'Register Now To Be Browser our Hot offer',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey
                        ),
                      ),
                      SizedBox(height: 30,),
                      Form(
                        key: formKey,
                        child: Column(
                            children: [
                              defaultTextFormField(
                                  controller: nameController,
                                  type: TextInputType.name,
                                  label: 'User Name',
                                  prefixIcon: Icons.email,
                                  kind: 'UserName'
                              ),
                              SizedBox(height: 20,),
                              defaultTextFormField(
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  label: 'Email',
                                  prefixIcon: Icons.email,
                                  kind: 'email'
                              ),
                              SizedBox(height: 20,),
                              defaultTextFormField(
                                  controller: passwordController,
                                  type: TextInputType.visiblePassword,
                                  label: 'Password',
                                  prefixIcon: Icons.lock,
                                  kind: 'Password',
                                  suffixIcon: SocialLoginCubit.get(context).suffix,
                                  showPass: (){
                                    SocialLoginCubit.get(context).changePasswordVisibility();
                                  },
                                  isPass: SocialLoginCubit.get(context).obscureText
                              ),
                              SizedBox(height: 20,),
                              defaultTextFormField(
                                  controller: phoneController,
                                  type: TextInputType.phone,
                                  label: 'Phone',
                                  prefixIcon: Icons.phone,
                                  kind: 'Phone'
                              ),
                              SizedBox(height: 20,),
                              ConditionalBuilder(
                                  condition: state is! SocialRegisterLoadingState,
                                  builder: (context)=>defaultButton(
                                      text: 'sgin in',
                                      onpressed: (){
                                        if(formKey.currentState!.validate()){
                                          SocialLoginCubit.get(context).registerUser(
                                              name: nameController.text,
                                              email: emailController.text,
                                              phone: phoneController.text,
                                              password: passwordController.text);
                                        }

                                      }), fallback: (BuildContext context)=>Container(),
                              )
                            ]
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

          );
        },
      );

  }
}

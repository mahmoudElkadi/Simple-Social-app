import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Network/local/sharedPrefernce.dart';
import 'package:social_app/component/cubit/Cubit.dart';
import 'package:social_app/layout/sociallayout.dart';

import '../../component/component/component.dart';
import '../../component/cubit/socialLoginCubit.dart';
import '../../component/cubit/states.dart';
import '../register/register.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    late final GlobalKey<FormState> formKey =GlobalKey<FormState>();

    return  BlocConsumer<SocialLoginCubit,SocialLoginState>(
        listener: (context,state){
          if (state is SocialLoginErrorState)
            showToast(msg: state.error, state: ToastStatus.ERROR);
          if(state is SocialLoginSuccessState){
            CacheHelper.saveData(key: 'uId',
                value:state.uId).then((value) {
                  navigateAndFinish(context, SocialHomeScreen());
            });
          }
        },
        builder: (context,state){
          return Scaffold(
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black
                        ),
                      ),
                      Text(
                        'Login Now To Browser Our Hot offer',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            defaultTextFormField(
                                controller: emailController,
                                type: TextInputType.visiblePassword,
                                label: 'Email',
                                prefixIcon: Icons.email,
                                kind: 'email'
                            ),
                            SizedBox(height: 20,),
                            defaultTextFormField(
                              controller: passwordController,
                              type: TextInputType.text,
                              label: 'Password',
                              prefixIcon: Icons.lock,
                              kind: 'Password',
                              suffixIcon: SocialLoginCubit.get(context).suffix,
                              showPass: (){
                                SocialLoginCubit.get(context).changePasswordVisibility();
                              },
                              isPass:SocialLoginCubit.get(context).obscureText,
                              onSubmit:(value){
                                if(formKey.currentState!.validate()){
                                  // SocialLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                                }
                              },
                            ),
                            SizedBox(height: 20,),
                            ConditionalBuilder(
                              condition: state is! SocialLoginLoadingState,
                              builder: (context)=> defaultButton(text: 'login', onpressed: (){
                                if(formKey.currentState!.validate()) {

                                  SocialLoginCubit.get(context).userLogin(email: '${emailController.text}', password: '${passwordController.text}') ;
                                }
                              }
                              ),


                              fallback: (context)=> Center(child: CircularProgressIndicator(),),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don\'t have an account?'),
                                defaultTextButton(function: (){
                                   navigateTo(context, RegisterScreen());
                                },
                                    text: 'Register Now')

                              ],
                            )
                          ],
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

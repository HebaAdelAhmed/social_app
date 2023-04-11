import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../layout/social_layout.dart';
import '../../shared/network/local/cache_helper.dart';
import '../social_login/cubit/cubit.dart';
import '../social_login/cubit/states.dart';
import '../social_registration/social_registration_screen.dart';

class SocialLoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialAppLoginCubit(),
        child: BlocConsumer<SocialAppLoginCubit , SocialAppLoginStates>(
          listener: (context, state) {
            if(state is SocialAppLoginErrorState){
              showToast(text: state.error, toastStates: ToastStates.ERROR);
            }
            if(state is SocialAppLoginSuccessState){
              CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
                navigateAndFinish(context: context, widget: SocialLayout());
              });
            }
          },
          builder: (context , state) {
            SocialAppLoginCubit cubit = SocialAppLoginCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                color: Colors.black
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Login now to communicate with other',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.grey
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          defaultTextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validation: (value){
                              if(value!.isEmpty){
                                return 'please enter your email address';
                              }
                            },
                            prefixIcon: Icons.email_outlined,
                            fieldName: 'Email Address',
                            controller: emailController,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultTextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              validation: (value){
                                if(value!.isEmpty){
                                  return 'please enter your password';
                                }
                              },
                              onSubmit: (value){
                                if(formKey.currentState!.validate()){
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                              prefixIcon: Icons.lock_outline,
                              fieldName: 'Password',
                              controller: passwordController,
                              obscureText: cubit.isPassword,
                              suffixIcon: cubit.suffix,
                              onPressedSuffixIcon: (){
                                cubit.changePasswordVisibility();
                              }
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! SocialAppLoginLoadingState,
                            builder: (context) => defaultButton(
                                text: 'LOGIN' ,
                                function: (){
                                  if(formKey.currentState!.validate()){
                                    cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text
                                    );
                                  }
                                }
                            ),
                            fallback: (context)=> Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  'Don\'t have an account?'
                              ),
                              defaultTextButton(
                                  text: 'Register now',
                                  function: (){
                                    navigateTo(
                                        context: context ,
                                        widget: SocialRegistrationScreen()
                                    );
                                  }
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
);
  }
}

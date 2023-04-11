import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../layout/social_layout.dart';
import '../social_login/cubit/states.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class SocialRegistrationScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController    = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController     = TextEditingController();
  TextEditingController phoneController    = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegistrationCubit(),
      child: BlocConsumer<SocialRegistrationCubit , SocialAppRegistrationStates>(
        listener: (context, state) {
          if(state is SocialAppUserCreateSuccessState){
            navigateAndFinish(context: context, widget: SocialLayout());
          }
        },
        builder: (context , state){
          SocialRegistrationCubit cubit = SocialRegistrationCubit.get(context);
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
                          'Registration',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Register now to communicate with other',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                          keyboardType: TextInputType.text,
                          validation: (value){
                            if(value!.isEmpty){
                              return 'please enter your name';
                            }
                          },
                          prefixIcon: Icons.person,
                          fieldName: 'Username',
                          controller: nameController,
                        ),
                        SizedBox(
                          height: 15,
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
                          keyboardType: TextInputType.number,
                          validation: (value){
                            if(value!.isEmpty){
                              return 'please enter your phone number';
                            }
                          },
                          prefixIcon: Icons.call,
                          fieldName: 'Phone Number',
                          controller: phoneController,
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
                                cubit.userRegister(
                                    phone: phoneController.text,
                                    name: nameController.text,
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
                              text: 'Register' ,
                              function: (){
                                if(formKey.currentState!.validate()){
                                  cubit.userRegister(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              }
                          ),
                          fallback: (context)=> Center(child: CircularProgressIndicator()),
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

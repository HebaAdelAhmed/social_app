import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'states.dart';

class SocialAppLoginCubit extends Cubit<SocialAppLoginStates>{

  SocialAppLoginCubit() : super(SocialAppLoginInitialState());

  static SocialAppLoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){

    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialAppChangePasswordVisibility());
  }

  void userLogin({required String email ,
    required String password
  }){
    emit(SocialAppLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialAppLoginSuccessState(uId: value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(SocialAppLoginErrorState(error: error.toString()));
    });
  }
}
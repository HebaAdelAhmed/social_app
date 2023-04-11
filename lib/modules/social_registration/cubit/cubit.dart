import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/social_user_model.dart';
import 'states.dart';

class SocialRegistrationCubit extends Cubit<SocialAppRegistrationStates>{

  SocialRegistrationCubit() : super(SocialAppRegistrationInitialState());

  static SocialRegistrationCubit get(context) => BlocProvider.of(context);

  // ShopLoginModel ? shopLoginModel;
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){

    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialAppRegistrationChangePasswordVisibility());
  }

  void userCreate({
    required String email ,
    required String name,
    required String phone,
    required String uId,
  }){

    SocialUserModel model = SocialUserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        isEmailVerified: false,
        bio: 'write your bio...',
        image: 'https://img.freepik.com/premium-photo/young-caucasian-woman-isolated-yellow-background-having-doubts-while-looking-up_1368-383207.jpg?w=1060',
        coverImage: 'https://img.freepik.com/free-photo/cheerful-positive-young-european-woman-with-dark-hair-broad-shining-smile-points-with-thumb-aside_273609-18325.jpg?w=1060&t=st=1675454233~exp=1675454833~hmac=666b36ce0deb9bae39e46b2d6241ff171a5fdb27c74781b44148cbc336e4ea8a',
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap()).then((value) {
          emit(SocialAppUserCreateSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialAppUserCreateErrorState(error: error.toString()));
    });
  }

  void userRegister({
    required String email ,
    required String password,
    required String name,
    required String phone,
  }){
    emit(SocialAppRegistrationLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(email: email, name: name, phone: phone, uId: value.user!.uid);
    }).catchError((error) {
      print(error.toString());
      emit(SocialAppRegistrationErrorState(error: error));
    });
  }
}
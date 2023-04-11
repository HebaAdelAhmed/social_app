import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../models/social_message_model.dart';
import '../../models/social_post_model.dart';
import '../../models/social_user_model.dart';
import '../../modules/chats/chats_screen.dart';
import '../../modules/feeds/feeds_screen.dart';
import '../../modules/new_post/new_post_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../modules/users/users_screen.dart';
import '../../shared/components/constants.dart';
import 'states.dart';

class SocialLayoutCubit extends Cubit<SocialLayoutStates>{
  SocialLayoutCubit() : super(SocialLayoutInitialState());

  static SocialLayoutCubit get(BuildContext context) => BlocProvider.of(context);

  SocialUserModel ? userModel;

  void getUserDate() {
    emit(SocialLayoutGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
          userModel = SocialUserModel.fromJson(value.data()!);
          print(value.data());
          print(userModel);
          emit(SocialLayoutGetUserSuccessState());
    }).catchError((error) {
          print(error.toString());
          emit(SocialLayoutGetUserErrorState(error: error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UserScreen(),
    SettingScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'New Post',
    'Users',
    'Settings',
  ];

  void removePostImage(){
    postImage = null;
    emit(SocialLayoutRemovePostImageState());
  }

  void changeBottomNavScreen(int index){
    if(index == 1)
      getAllUsers();
    if(index == 2)
      emit(SocialLayoutNewPostState());
    else
      currentIndex = index;
      emit(SocialLayoutChangeBottomNavState());
  }

  File ? profileImage;
  var picker = ImagePicker();

  Future getProfileImage()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialLayoutProfileImagePickedSuccessState());
    }else{
      print('No Image Picked');
      emit(SocialLayoutProfileImagePickedErrorState());
    }
  }

  File ? coverImage;

  Future getCoverImage()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialLayoutCoverImagePickedSuccessState());
    }else{
      print('No Image Picked');
      emit(SocialLayoutCoverImagePickedErrorState());
    }
  }


  // String profileImageUrl = '';
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
}){
    emit(SocialLayoutUploadUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value){
          value.ref.getDownloadURL().then((value) {
            // emit(SocialLayoutUploadProfileImageSuccessState());
            print(value);
            // profileImageUrl = value;
            updateUser(
                name: name,
                phone: phone,
                bio: bio,
              profileImage: value,
            );
          }).catchError((error){
            emit(SocialLayoutUploadProfileImageErrorState());
          });
        }).catchError((error){
      emit(SocialLayoutUploadProfileImageErrorState());

    });
  }


  // String coverImageUrl = '';
  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
}){
    emit(SocialLayoutUploadUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value){
      value.ref.getDownloadURL().then((value) {
        // emit(SocialLayoutUploadCoverImageSuccessState());
        print(value);
        // coverImageUrl = value;
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
            coverImage: value,
        );
      }).catchError((error){
        emit(SocialLayoutUploadCoverImageErrorState());
      });
    }).catchError((error){
      emit(SocialLayoutUploadCoverImageErrorState());

    });
  }

//   void updateUserImages({
//     required String name,
//     required String phone,
//     required String bio,
// }){
//
//     emit(SocialLayoutUploadUserLoadingState());
//     if(coverImage != null && profileImage != null){
//       SocialUserModel model = SocialUserModel(
//         name: name,
//         phone: phone,
//         isEmailVerified: false,
//         bio: bio,
//         coverImage: coverImageUrl,
//         image: profileImageUrl,
//         uId: userModel!.uId,
//         email: userModel!.email,
//       );
//
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc(userModel!.uId)
//           .update(model.toMap())
//           .then((value) {
//         getUserDate();
//       }).catchError((error){
//         emit(SocialLayoutUploadUserErrorState());
//       });
//     }
//     else if(coverImage != null){
//       uploadCoverImage();
//     }else{
//       SocialUserModel model = SocialUserModel(
//         name: name,
//         phone: phone,
//         isEmailVerified: false,
//         bio: bio,
//         coverImage: coverImageUrl,
//         image: userModel!.image,
//         uId: userModel!.uId,
//         email: userModel!.email,
//       );
//
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc(userModel!.uId)
//           .update(model.toMap())
//           .then((value) {
//         getUserDate();
//       }).catchError((error){
//         emit(SocialLayoutUploadUserErrorState());
//       });
//     }
//     if(profileImage != null){
//       uploadProfileImage();
//     }
//     else{
//       SocialUserModel model = SocialUserModel(
//         name: name,
//         phone: phone,
//         isEmailVerified: false,
//         bio: bio,
//         image: profileImageUrl,
//         email: userModel!.email,
//         coverImage: userModel!.coverImage,
//         uId: userModel!.uId,
//       );
//
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc(userModel!.uId)
//           .update(model.toMap())
//           .then((value) {
//         getUserDate();
//       }).catchError((error){
//         emit(SocialLayoutUploadUserErrorState());
//       });
//     }
//     updateUser(
//         name: name,
//         phone: phone,
//         bio: bio,
//     );
//   }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String ? profileImage,
    String ? coverImage,
}){
    emit(SocialLayoutUploadUserLoadingState());
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      isEmailVerified: false,
      bio: bio,
      uId: userModel!.uId,
      coverImage: coverImage ?? userModel!.coverImage,
      email: userModel!.email,
      image: profileImage ?? userModel!.image,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserDate();
    }).catchError((error){
      emit(SocialLayoutUploadUserErrorState());
    });

  }

  File ? postImage;

  Future getPostImage()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialLayoutPostImagePickedSuccessState());
    }else{
      print('No Image Picked');
      emit(SocialLayoutPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String datetime,
    required String text,
}){
    emit(SocialLayoutCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value){
      value.ref.getDownloadURL().then((value) {
        // emit(SocialLayoutUploadCoverImageSuccessState());
        print(value);
        createPost(datetime: datetime, text: text, postImage: value);
        // coverImageUrl = value;

      }).catchError((error){
        emit(SocialLayoutPostImagePickedErrorState());
      });
    }).catchError((error){
      emit(SocialLayoutPostImagePickedErrorState());

    });
  }

  void createPost({
    required String datetime,
    required String text,
    String ? postImage
}){
    emit(SocialLayoutCreatePostLoadingState());
    SocialPostModel model = SocialPostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: datetime,
      textPost: text,
      imagePost: postImage?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
          emit(SocialLayoutPostImagePickedSuccessState());
    }).catchError((error){
      emit(SocialLayoutCreatePostErrorState());
    });
  }

  List<SocialPostModel> posts =[];
  List<String> postId = [];
  List<int> likes = [];

  void getPosts(){
    emit(SocialLayoutGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            element.reference
                .collection('likes')
                .get()
                .then((value) {
                  likes.add(value.docs.length);
                  posts.add(SocialPostModel.fromJson(element.data()));
                  postId.add(element.id);
            }).catchError((error){

            });

          });
          emit(SocialLayoutGetPostsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialLayoutGetPostsErrorState(error: error));
    });
  }

  void likePost(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like':true,
    })
        .then((value) {
          emit(SocialLayoutLikePostSuccessState());
    }).catchError((error){
      emit(SocialLayoutLikePostErrorState(error: error));
    });
  }

  List<SocialUserModel> users = [];

  void getAllUsers(){
    emit(SocialLayoutGetAllUsersLoadingState());
    if(users.length == 0)
      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if(element.data()['uId'] != userModel!.uId)
            users.add(SocialUserModel.fromJson(element.data()));
          emit(SocialLayoutGetAllUsersSuccessState());
          });
         }).catchError((error){
            emit(SocialLayoutGetAllUsersErrorState(error: error));
         });
  }

  void sendMessage({
    required String message,
    required String receiverId,
    required String dateTime,
}){
    SocialMessageModel model = SocialMessageModel(
      text: message,
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: userModel!.uId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
          emit(SocialSendMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialGetMessageSuccessState());
    }).catchError((error){
      emit(SocialGetMessageErrorState());
    });
  }
  
  List<SocialMessageModel> messages = [];
  
  void getMessages({
  required String receiverId,
}){
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
          event.docs.forEach((element) {
            messages.add(SocialMessageModel.fromJson(element.data()));
          });

          emit(SocialGetMessageSuccessState());
    });
  }
}
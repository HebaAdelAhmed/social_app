import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../shared/components/components.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit , SocialLayoutStates>(
      listener: (context, state) {


      },
      builder: (context, state) {
        var userModel = SocialLayoutCubit.get(context).userModel;
        var profileImage = SocialLayoutCubit.get(context).profileImage;
        var coverImage = SocialLayoutCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel!.bio!;
        phoneController.text = userModel!.phone!;

        return Scaffold(
          appBar: defaultAppBar(
            title: 'Edit Profile',
            context: context,
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 8.0),
                child: defaultTextButton(
                  text: 'Update',
                  function: (){
                    SocialLayoutCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                    );
                  },
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                if(state is SocialLayoutUploadUserLoadingState)
                  LinearProgressIndicator(),
                SizedBox(
                  height:5,
                ),
                Container(
                  height: 195.0,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0),
                                ),
                                image: DecorationImage(
                                  image: coverImage == null? NetworkImage('${userModel!.coverImage}'): FileImage(coverImage!) as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                SocialLayoutCubit.get(context).getCoverImage();
                              },
                              icon: CircleAvatar(
                                radius: 20,
                                  child: Icon(
                                      IconBroken.Camera,
                                  ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 53,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                              child: Image(
                                image: profileImage == null? NetworkImage(userModel!.image!): FileImage(profileImage!) as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: (){
                              SocialLayoutCubit.get(context).getProfileImage();
                            },
                            icon: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                IconBroken.Camera,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if(SocialLayoutCubit.get(context).coverImage != null || SocialLayoutCubit.get(context).profileImage != null)
                  Row(
                  children: [
                    if(SocialLayoutCubit.get(context).profileImage != null)
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultButton(
                                function: (){
                                  SocialLayoutCubit.get(context).uploadProfileImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                },
                                text: 'Upload Profile',
                            ),
                            if(state is SocialLayoutUploadUserLoadingState)
                            SizedBox(
                              height: 5,
                            ),
                            if(state is SocialLayoutUploadUserLoadingState)
                            LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    if(SocialLayoutCubit.get(context).profileImage != null)
                      SizedBox(
                      width: 5,
                    ),
                    if(SocialLayoutCubit.get(context).coverImage != null)
                     Expanded(
                       child: Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           defaultButton(
                             function: (){
                               SocialLayoutCubit.get(context).uploadCoverImage(
                                 name: nameController.text,
                                 phone: phoneController.text,
                                 bio: bioController.text,
                               );
                             },
                             text: 'Upload Cover',
                           ),
                           if(state is SocialLayoutUploadUserLoadingState)
                             SizedBox(
                               height: 5,
                             ),
                           if(state is SocialLayoutUploadUserLoadingState)
                             LinearProgressIndicator(),
                         ],
                       ),
                     ),

                  ],
                ),
                if(SocialLayoutCubit.get(context).coverImage != null || SocialLayoutCubit.get(context).profileImage != null)
                  SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validation: (value){
                      if(value!.isEmpty)
                        return 'Name can\'t be empty';
                      return null;
                    },
                    fieldName: 'Name',
                    prefixIcon: IconBroken.User,
                ),
                SizedBox(
                  height: 10,
                ),
                defaultTextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  validation: (value){
                    if(value!.isEmpty)
                      return 'Phone can\'t be empty';
                    return null;
                  },
                  fieldName: 'Phone',
                  prefixIcon: IconBroken.Call,
                ),
                SizedBox(
                  height: 10,
                ),
                defaultTextFormField(
                  controller: bioController,
                  keyboardType: TextInputType.text,
                  validation: (value){
                    if(value!.isEmpty)
                      return 'Bio can\'t be empty';
                    return null;
                  },
                  fieldName: 'Bio',
                  prefixIcon: IconBroken.Info_Circle,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

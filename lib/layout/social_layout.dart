import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/new_post/new_post_screen.dart';
import '../shared/components/components.dart';
import '../shared/styles/icon_broken.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit , SocialLayoutStates>(
      listener: (context, state) {
        if(state is SocialLayoutNewPostState)
          navigateTo(context: context, widget: NewPostScreen());
      },
      builder: (context, state) {
        SocialLayoutCubit cubit = SocialLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex]
            ),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(
                    IconBroken.Notification,
                  ),
              ),
              IconButton(
                onPressed: (){},
                icon: Icon(
                  IconBroken.Search,
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Chat,
                ),
                label: 'Chats'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Paper_Upload,
                  ),
                  label: 'Post'
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Location,
                ),
                label: 'Users'
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Setting,
                ),
                label: 'Settings'
              ),
            ],
            onTap: (index){
              cubit.changeBottomNavScreen(index);
            },
          ),
          body: cubit.screens[cubit.currentIndex],
          // body: ConditionalBuilder(
          //   condition: cubit.dart.model != null,
          //   builder: (context) {
          //     return Column(
          //       children: [
          //         // if(!FirebaseAuth.instance.currentUser!.emailVerified)
          //         //   Container(
          //         //   color: Colors.amber.withOpacity(0.6),
          //         //   child: Padding(
          //         //     padding: const EdgeInsets.all(8.0),
          //         //     child: Row(
          //         //       children: [
          //         //         Icon(Icons.warning_amber_outlined),
          //         //         SizedBox(
          //         //           width: 10,
          //         //         ),
          //         //         Text(
          //         //           'Please verify your email',
          //         //         ),
          //         //         Spacer(),
          //         //         defaultTextButton(
          //         //           function: (){
          //         //             FirebaseAuth.instance
          //         //                 .currentUser!
          //         //                 .sendEmailVerification()
          //         //                 .then((value) {
          //         //               showToast(
          //         //                   text: 'Check Your mail',
          //         //                   toastStates: ToastStates.SUCCESS
          //         //               );
          //         //             }).catchError((error){
          //         //               print(error.toString());
          //         //             });
          //         //           },
          //         //           text: 'Send',
          //         //         ),
          //         //       ],
          //         //     ),
          //         //   ),
          //         // ),
          //
          //       ],
          //     );
          //   },
          //   fallback: (context) => Center(child: CircularProgressIndicator()),
          // ),
        );
      },
    );
  }
}

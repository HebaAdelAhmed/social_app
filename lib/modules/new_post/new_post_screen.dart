import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);

  TextEditingController postController = TextEditingController();
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit , SocialLayoutStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            title: 'Create Post',
            context: context,
            actions: [
              defaultTextButton(text: 'POST', function: (){
                if(SocialLayoutCubit.get(context).postImage == null){
                  SocialLayoutCubit.get(context).createPost(
                    datetime: now.toString(),
                    text: postController.text,
                  );
                }else{
                  SocialLayoutCubit.get(context).uploadPostImage(
                    datetime: now.toString(),
                    text: postController.text,
                  );
                }
              }),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialLayoutCreatePostLoadingState)
                LinearProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        SocialLayoutCubit.get(context).userModel!.image!
                      ),
                      radius: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            SocialLayoutCubit.get(context).userModel!.name!,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Public',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    decoration: InputDecoration(
                        hintText: 'What is on your mind?',
                      border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if(SocialLayoutCubit.get(context).postImage != null)
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: FileImage(
                                  SocialLayoutCubit.get(context).postImage!
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            SocialLayoutCubit.get(context).removePostImage();
                          },
                          icon: CircleAvatar(
                            radius: 20,
                            child: Icon(
                              Icons.close
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if(SocialLayoutCubit.get(context).postImage != null)
                  SizedBox(
                    height: 20,
                  ),
                Row(
                  children: [
                    TextButton(onPressed: (){
                      SocialLayoutCubit.get(context).getPostImage();
                    }, child: Row(
                      children: [
                        Icon(IconBroken.Image),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Add Photo')
                      ],
                     ),
                    ),
                    Spacer(),
                    Expanded(
                      child: TextButton(onPressed: (){}, child: Text('# Tags'),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),

        );
      },
    );
  }
}

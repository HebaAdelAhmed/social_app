import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/social_post_model.dart';
import '../../shared/styles/icon_broken.dart';


class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit , SocialLayoutStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialLayoutCubit.get(context).posts.length > 0 && SocialLayoutCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Image(
                        image: NetworkImage(
                          'https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?w=1060&t=st=1675390056~exp=1675390656~hmac=11f6213410dbb384eaf87de580154f359ef930b683776301343f2d76853804e5',
                        ),
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Communicate with friends',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                  elevation: 10.0,
                  margin: EdgeInsetsDirectional.all(8.0),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(
                      SocialLayoutCubit.get(context).posts[index] ,
                      context ,
                      SocialLayoutCubit.get(context).postId[index],
                      index,
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 15,
                  ),
                  itemCount: SocialLayoutCubit.get(context).posts.length,
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(SocialPostModel model , BuildContext context , String postId , int index){
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    '${model.image}'
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
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blueAccent,
                            size: 14,
                          ),
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  alignment: AlignmentDirectional.topEnd,
                  onPressed: (){},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 18,
                  ),
                ),
              ],
            ),
            Divider(),
            Text(
              '${model.textPost}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
            // SizedBox(
            //   width: double.infinity,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 8.0),
            //     child: Wrap(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 8.0),
            //           child: Container(
            //             height: 25.0,
            //             child: MaterialButton(
            //               onPressed: (){},
            //               padding: EdgeInsets.zero,
            //               minWidth: 1.0,
            //               child: Text(
            //                 '#software' ,
            //                 style: TextStyle(
            //                     color: Colors.blueAccent,
            //                     fontWeight: FontWeight.w600
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 8.0),
            //           child: Container(
            //             height: 25.0,
            //             child: MaterialButton(
            //               onPressed: (){},
            //               padding: EdgeInsets.zero,
            //               minWidth: 1.0,
            //               child: Text(
            //                 '#software' ,
            //                 style: TextStyle(
            //                     color: Colors.blueAccent,
            //                     fontWeight: FontWeight.w600
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            if(model.imagePost != '')
              Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                elevation: 5.0,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    '${model.imagePost}'
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.redAccent,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${SocialLayoutCubit.get(context).likes[index]}',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '0 comments',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              '${SocialLayoutCubit.get(context).userModel!.image}'
                            ),
                            radius: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Write a comment...',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      SocialLayoutCubit.get(context).likePost(postId);
                    },
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Upload,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Share',
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
            ),
          ],
        ),
      ),
    );
  }
}

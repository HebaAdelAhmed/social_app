import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/social_message_model.dart';
import '../../models/social_user_model.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {

  SocialUserModel userModel;
  ChatDetailsScreen({
    required this.userModel,
});
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialLayoutCubit.get(context).getMessages(receiverId: userModel.uId!);
        return BlocConsumer<SocialLayoutCubit , SocialLayoutStates>(
          listener: (context, state) {
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        '${userModel.image}',
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${userModel.name}',
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialLayoutCubit.get(context).messages.length > 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            if(SocialLayoutCubit.get(context).userModel!.uId == SocialLayoutCubit.get(context).messages[index].senderId)
                              return buildMyMessage(SocialLayoutCubit.get(context).messages[index]);
                            else
                              return buildMessage(SocialLayoutCubit.get(context).messages[index]);
                          },
                          separatorBuilder: (context, index) => SizedBox(height: 10,),
                          itemCount: SocialLayoutCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  controller: textController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type your message here...'
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              child: MaterialButton(
                                onPressed: (){
                                  SocialLayoutCubit.get(context).sendMessage(
                                    message: textController.text,
                                    receiverId: userModel.uId!,
                                    dateTime: DateTime.now().toString(),
                                  );
                                  textController.text = '';
                                },
                                child: Icon(
                                  IconBroken.Send,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                color: defaultColor,
                                minWidth: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      }
    );
  }

  Widget buildMessage(SocialMessageModel model){
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
          ),
          color: Colors.grey[300],
        ),
        padding: EdgeInsets.symmetric(vertical: 5 , horizontal: 10),
        child: Text(
          '${model.text}',
        ),
      ),
    );
  }

  Widget buildMyMessage(SocialMessageModel model){
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
          ),
          color: defaultColor.withOpacity(0.2),
        ),
        padding: EdgeInsets.symmetric(vertical: 5 , horizontal: 10),
        child: Text(
          '${model.text}',
        ),
      ),
    );
  }
}

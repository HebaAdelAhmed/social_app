import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/social_user_model.dart';
import '../../shared/components/components.dart';
import '../chat_details/chat_details_screen.dart';


class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit , SocialLayoutStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: SocialLayoutCubit.get(context).users.length > 0,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(
                  SocialLayoutCubit.get(context).users[index],
                  context,
              ),
              separatorBuilder: (context, index) => Divider(),
              itemCount: SocialLayoutCubit.get(context).users.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator(),),
          );
        },
    );
  }

  Widget buildChatItem(SocialUserModel model , BuildContext context){
    return InkWell(
      onTap: (){
        navigateTo(context: context, widget: ChatDetailsScreen(userModel: model));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text(
                    '${model.name}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    'Hello Heba Hpssdsdsdsdsdsdm ldkfndfdnf ldnladfnlafndalf csdsdsjdnakdas dlndlasdnlasdhsdhsald ldalsdhdhal',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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

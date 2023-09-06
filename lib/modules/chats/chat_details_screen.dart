import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/shopAppLogin/cubit.dart';
import 'package:social_app/cubit/social_cubit/states.dart';
import 'package:social_app/models/send_message_model.dart';
import 'package:social_app/models/user_create_model.dart';
import 'package:social_app/styles/colors.dart';

import '../../cubit/social_cubit/cubit.dart';
import '../../styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserCreateModel? model;
  ChatDetailsScreen(this.model, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverId: model?.uId);
        return BlocConsumer<SocialCubit, SocialCubitStates>(
          listener: (context, state) {},
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(IconBroken.Arrow___Left_2)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    maxRadius: 25,
                    backgroundImage: NetworkImage("${model?.image}"),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    "${model?.name}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(height: 1.4),
                  ),
                ],
              ),
              elevation: 1.0,
            ),
            body: ConditionalBuilder(
              condition: true,
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
              builder: (context) => Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var message = SocialCubit.get(context).message[index];
                          if (SocialCubit.get(context).userModel?.uId ==
                              message.senderId) {
                            return buildMyMessage(message);
                          }
                          return buildMessage(message);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 15.0,
                            ),
                        itemCount: SocialCubit.get(context).message.length),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 1.0, color: Colors.grey)),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                label: Text("Type Your message here"),
                              ),
                            ),
                          ),
                          Container(
                            height: 60.0,
                            color: Colors.blue[300],
                            child: MaterialButton(
                              minWidth: 1.0,
                              onPressed: () {
                                SocialCubit.get(context).sendMessages(
                                    receiverId: model?.uId,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text);
                                messageController.text = '';
                              },
                              child: Icon(IconBroken.Send, size: 30.0),
                            ),
                          )

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0,top: 10.0,right: 10.0),
          child: Container(

            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                )),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("${model.text}"),
            ),
          ),
        ),
      );
  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0,top: 10.0,right: 10.0),
          child: Container(

            decoration: BoxDecoration(
                color: defaultColor.withOpacity(.4),
                borderRadius: const BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                )),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("${model.text}"),
            ),
          ),
        ),
      );
}

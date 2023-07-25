// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/chat_model.dart';
import 'package:social/models/user_model.dart';
import 'package:social/shared/style/colors.dart';

import '../../shared/style/icon_broken.dart';

class ShatDetailsScreen extends StatelessWidget {
  UserModel userModel;
  ShatDetailsScreen({super.key, required this.userModel});
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessage(reseiverId: userModel.uId!);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, states) => Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('${userModel.image}'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      '${userModel.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ConditionalBuilder(
                    condition: SocialCubit.get(context).message.isNotEmpty,
                    builder: (context) => Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          var message = SocialCubit.get(context).message[index];
                          if (SocialCubit.get(context).model!.uId ==
                              message.senderId) {
                            return buildMyMessage(
                                SocialCubit.get(context).message[index]);
                          }
                          return buildMessage(
                              SocialCubit.get(context).message[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: 10,
                        ),
                        itemCount: SocialCubit.get(context).message.length,
                      ),
                    ),
                    fallback: (BuildContext context) => Column(
                      children: [
                        const Icon(
                          IconBroken.chat,
                          size: 100,
                          color: defaultColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'There is no Chate',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: defaultColor),
                        ),
                      ],
                    ),
                  ),
             
                  buildWritemessage(context, userModel),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildMessage(ChatModel model) => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text('${model.text}'),
        ),
      );
  Widget buildMyMessage(ChatModel model) => Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: BoxDecoration(
            color: orange,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text('${model.text}'),
        ),
      );
  Widget buildWritemessage(context, userModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: defaultColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: InputBorder.none,
              ),
              controller: messageController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: const TextStyle(fontSize: 16),
              cursorHeight: 20,
            ),
          ),
          Container(
            height: 50,
            color: defaultColor,
            child: MaterialButton(
              minWidth: 1,
              padding: const EdgeInsets.all(0),
              onPressed: () {
                SocialCubit.get(context).sendMessage(
                  text: messageController.text,
                  reseiverId: userModel!.uId,
                  dateTime: DateTime.now().toString(),
                );
                messageController.clear();
              },
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 16,
              ),
              // child: IconButton(
              //   onPressed: () {
              //     // SocialCubit.get(context).createComment(
              //     //   postId: postId,
              //     //   dateTime: now.toString(),
              //     //   text: commentController.text,
              //     // );

              //   },
              //   icon: Transform.translate(
              //     offset: const Offset(10, 0),
              //     child: const Icon(
              //       Icons.arrow_forward_ios_rounded,
              //       color: defaultColor,
              //       size: 30,
              //     ),
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}

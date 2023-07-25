// ignore_for_file: prefer_const_constructors, implementation_imports

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/models/user_model.dart';
import 'package:social/shared/components/components.dart';

import '../../shared/style/icon_broken.dart';
import '../chat_detailes/chat_detailes.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chats',
        ),
        actions: [
          IconButton(
            icon: Icon(
              IconBroken.search,
            ),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(IconBroken.notification),
          ),
        ],
      ),
      body: ConditionalBuilder(
        condition: SocialCubit.get(context).users.isNotEmpty,
        builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, index) =>
                buildUsersRow(context, SocialCubit.get(context).users[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: SocialCubit.get(context).users.length),
        fallback: (BuildContext context) => Center(
          child: Text('No Users!', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  Widget buildUsersRow(context, UserModel userModel) {
    return InkWell(
      onTap: () {
        navigateTo(context, ShatDetailsScreen(userModel: userModel));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage('${userModel.image}'),
            ),
            SizedBox(
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
    );
  }
}

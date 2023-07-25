// ignore_for_file: prefer_const_constructors, implementation_imports, unused_local_variable

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:social/models/user_model.dart';
import 'package:social/modules/update/update.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/style/icon_broken.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var userModel = SocialCubit.get(context).model;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Setting',
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
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  buildCoverAndProfileImages(userModel!, context),
                  SizedBox(
                    height: 10,
                  ),
                  buildUsernameAndBio(userModel, context),
                  SizedBox(
                    height: 30,
                  ),
                  buildSectionHead(context),
                  SizedBox(
                    height: 20,
                  ),
                  addAndEditRow(context, userModel),
                  
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCoverAndProfileImages(UserModel userModel, context) {
    return SizedBox(
      height: 220,
      child: Stack(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage('${userModel.cover}'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          CircleAvatar(
            radius: 47,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage('${userModel.image}'),
          ),
        ],
      ),
    );
  }

  Widget buildUsernameAndBio(UserModel userModel, context) {
    return Column(
      children: [
        Text(
          '${userModel.name}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '${userModel.bio}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget buildSectionHead(context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                '100',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                'Posts',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                '250',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                'Photos',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                '10k',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                'Followers',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children:  [
              Text(
                '300',
                style:  Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                'Following',
                style:  Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget addAndEditRow(context, userModel) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            child: Text(
              'Edit',
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        OutlinedButton(
          onPressed: () {
            navigateTo(context, UpdateScreen());
          },
          child: Icon(Icons.edit_outlined),
        ),
      ],
    );
  }
}

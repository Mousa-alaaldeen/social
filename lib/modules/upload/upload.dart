// ignore_for_file: prefer_const_constructors, implementation_imports, must_be_immutable, unused_local_variable

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/style/icon_broken.dart';

import '../../models/user_model.dart';

class UploadScreen extends StatelessWidget {
  UploadScreen({super.key});
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {
        if (state is SocialCreatPostSuccessState) {
          
          showToast(
              text: 'Post Updated  successfully!', state: ToastState.sUCCESS);
              Navigator.pop(context);
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = SocialCubit.get(context).model;
        return Scaffold(
          appBar: myAppBar(title: 'Add Post', context: context, actions: [
            TextButton(
              onPressed: () {
                var now = DateTime.now();
                if (SocialCubit.get(context).postImage == null &&
                    textController == null) { showToast(
              text: 'Error', state: ToastState.eRORR);}
               else if (SocialCubit.get(context).postImage != null) {
                  SocialCubit.get(context).uplodPostImage(
                      dateTime: now.toString(), text: textController.text);
                } else {
                  SocialCubit.get(context).criateNewPost(
                      dateTime: now.toString(), text: textController.text);
                }
                textController.clear();
              },
              child: Text(
                'Post',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ]),
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if (state is SocialCreatPostLodingState)
                        LinearProgressIndicator(),
                      if (state is SocialCreatPostLodingState)
                        SizedBox(
                          height: 10,
                        ),
                      buildUserInfo(context),
                      SizedBox(
                        height: 20,
                      ),
                      buildPost(),
                      SizedBox(
                        height: 20,
                      ),
                      if (SocialCubit.get(context).postImage != null)
                        buildPostImage(
                            SocialCubit.get(context).model!, context),
                      buildAddImageButton(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildUserInfo(
    context,
  ) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage:
              NetworkImage('${SocialCubit.get(context).model!.image}'),
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          '${SocialCubit.get(context).model!.name}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.4),
        ),
      ],
    );
  }

  buildPost() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
            hintText: 'Whate is on your mind....', border: InputBorder.none),
        keyboardType: TextInputType.multiline,
        controller: textController,
      ),
    );
  }

  Widget buildPostImage(UserModel model, context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: FileImage(SocialCubit.get(context).postImage!),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 17,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                SocialCubit.get(context).removePostImage();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildAddImageButton(context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              SocialCubit.get(context).getPostImage();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(IconBroken.image),
                Text('add image'),
              ],
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: Text('# tags'),
          ),
        ),
      ],
    );
  }
}

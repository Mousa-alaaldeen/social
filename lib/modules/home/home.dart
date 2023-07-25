// ignore_for_file: prefer_const_constructors, implementation_imports, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/post_model.dart';

import 'package:social/shared/components/components.dart';
import 'package:social/shared/components/constantes.dart';
import 'package:social/shared/style/icon_broken.dart';

import '../comments/comment.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      SocialCubit.get(context).getMyPosts();
      return BlocConsumer<SocialCubit, SocialStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            return ConditionalBuilder(
              condition: SocialCubit.get(context).posts.isNotEmpty &&
                  SocialCubit.get(context).model != null,
              builder: (BuildContext context) => Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Home',
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
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      buildHomeCover(context),
                      ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildPost(
                                context,
                                SocialCubit.get(context).posts[index],
                                index,
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 5,
                              ),
                          itemCount: SocialCubit.get(context).posts.length),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              fallback: (BuildContext context) =>
                  Center(child: Center(child: CircularProgressIndicator())),
            );
          });
    });
  }

  Widget buildPost(context, PostModel postModel, index) => Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 5.0,
        margin: EdgeInsets.all(8.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildUserInfo(context, postModel, index),
              Padding(
                padding: const EdgeInsets.only(bottom: 15, top: 10),
                child: myDivider(),
              ),
              if (postModel.text != '') buildTextPost(context, postModel),
              // Padding(
              //   padding: const EdgeInsets.only(top: 10),
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         SizedBox(
              //           height: 20,
              //           child: MaterialButton(
              //             height: 25,
              //             minWidth: 1,
              //             padding: EdgeInsets.zero,
              //             onPressed: () {},
              //             child: Text(
              //               'software',
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .bodyMedium!
              //                   .copyWith(
              //                     color: Colors.blue,
              //                   ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if (postModel.postImage != '') buildPostImage(postModel),

              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        SocialCubit.get(context)
                            .likePost(SocialCubit.get(context).postId[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.heart,
                              color: Colors.red,
                              size: 16.0,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                                '${SocialCubit.get(context).likesNumber[index]}',
                                style: Theme.of(context).textTheme.bodySmall!),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.chat,
                              color: Colors.amber,
                              size: 16.0,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('100',
                                style: Theme.of(context).textTheme.bodySmall!),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Comment',
                                style: Theme.of(context).textTheme.bodySmall!),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              buildDivider(),

              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        navigateTo(
                            context,
                            CommentsScreen(
                              postId: SocialCubit.get(context).postId[index],
                            ));
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).model!.image}'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Write a comment..',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).likePost(SocialCubit.get(context)
                          .likePost(SocialCubit.get(context).postId[index]));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.heart,
                            color: Colors.red,
                            size: 16.0,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Like',
                              style: Theme.of(context).textTheme.bodySmall!),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  Widget buildHomeCover(context) {
    return Card(
      color: Colors.black,
      elevation: 5.0,
      margin: EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Image(
            image: NetworkImage(
                'https://img.freepik.com/free-photo/handsome-man-white-shirt-posing-attractive-guy-with-fashion-hairstyle-confident-man-with-short-beard-adult-boy-with-brown-hair-closeup-portrait_186202-8538.jpg?w=900&t=st=1688302616~exp=1688303216~hmac=76ebcac7555bcb6bbe8a8d6df6ed9a2dc4dc23e23ef2e21295b81ccdc4fad435'),
            fit: BoxFit.fill,
            height: 200,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Communicat with frinds',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUserInfo(context, PostModel postModel, index) {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage('${postModel.image}'),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${postModel.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(height: 1.4),
              ),
              Text(
                '${postModel.dartTime}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(height: 1.4),
              ),
            ],
          ),
        ),
        if (postModel.uId == uId)
          IconButton(
            onPressed: () {
              SocialCubit.get(context)
                  .deletePost(postId: SocialCubit.get(context).postId[index]);
            },
            icon: Icon(
              Icons.more_horiz,
              size: 20,
            ),
          ),
      ],
    );
  }

  Widget buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: myDivider(),
    );
  }

  Widget buildTextPost(context, PostModel postModel) {
    return Column(
      children: [
        Text(
          '${postModel.text}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget buildPostImage(PostModel postModel) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: NetworkImage('${postModel.postImage}'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

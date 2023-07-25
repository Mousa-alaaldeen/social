// ignore_for_file: unnecessary_import, implementation_imports, prefer_const_constructors, unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/modules/login/login_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/style/icon_broken.dart';

import '../modules/upload/upload.dart';
import '../shared/network/local/cache_helper.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, Object? state) {
        if (state is NavigateToPostScreenState) {
          navigateTo(context, UploadScreen());
        }
      },
      builder: (BuildContext context, state) {
        Size size = MediaQuery.of(context).size;
        var model = SocialCubit.get(context).model;
        return ConditionalBuilder(
          condition: SocialCubit.get(context).model != null,
          builder: (BuildContext context) => Scaffold(
            body: SocialCubit.get(context)
                .widgetScreen[SocialCubit.get(context).currentIndex],
            // Column(
            //   children: [
            //     if (FirebaseAuth.instance.currentUser!.emailVerified)
            //       Container(
            //         height: 50,
            //         color: Colors.amber.withOpacity(.8),
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 10),
            //           child: Row(
            //             children: [
            //               Icon(Icons.info_outline),
            //               SizedBox(
            //                 width: 15,
            //               ),
            //               Expanded(child: Text('Please verify your email')),
            //               deffaultTextButton(
            //                 onPressed: () {
            //                   FirebaseAuth.instance.currentUser!
            //                       .sendEmailVerification()
            //                       .then((value) {
            //                     showToast(
            //                         text: 'check your mail',
            //                         state: ToastState.sUCCESS);
            //                   }).catchError((error) {});
            //                 },
            //                 text: 'Send',
            //               ),
            //             ],
            //           ),
            //         ),
            //       )
            //   ],
            // ),

            bottomNavigationBar: SnakeNavigationBar.gradient(
              currentIndex: SocialCubit.get(context).currentIndex,
              onTap: (index) => SocialCubit.get(context).changeBottom(index),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.chat), label: 'Chats'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.paperUpload), label: 'Post'),
                BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.location,
                    ),
                    label: 'Users'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.setting), label: 'Setting'),
              ],
            ),
            drawer: SafeArea(
              child: Container(
                child: ListTileTheme(
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 128.0,
                        height: 128.0,
                        margin: const EdgeInsets.only(
                          top: 24.0,
                          bottom: 64.0,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).model!.image}'),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.home),
                        title: Text('Home'),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.account_circle_rounded),
                        title: Text('Profile'),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.favorite),
                        title: Text('Favourites'),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.settings),
                        title: Text('Settings'),
                      ),
                      ListTile(
                        onTap: () {
                          SocialCubit.get(context).appChangeMode();
                        },
                        leading: Icon(Icons.brightness_4_outlined),
                        title: Text('Darek  and Light'),
                      ),
                      Spacer(),
                      ListTile(
                        onTap: () {
                          CacheHelper.removeData(key: 'uId').then((value) {
                            navigateAndFinish(context, LoginScreen());
                          });
                        },
                        leading: Icon(Icons.logout),
                        title: Text('Log out'),
                      ),
                      DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 16.0,
                          ),
                          child: Text('Terms of Service | Privacy Policy'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          fallback: (BuildContext context) =>
              Center(child: Center(child: CircularProgressIndicator())),
        );
      },
    );
  }
}

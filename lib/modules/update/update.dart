// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/style/icon_broken.dart';

class UpdateScreen extends StatelessWidget {
  UpdateScreen({super.key});
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var userModel = SocialCubit.get(context).model;
        var coverImage = SocialCubit.get(context).coverImage;
        var profileImage = SocialCubit.get(context).profileImage;
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

        return Scaffold(
          // backgroundColor: Colors.black,
          appBar:  myAppBar(
              context: context,
              title:'Update'  ,
              actions: [
                deffaultTextButton(
                  context: context,
                    onPressed: () {
                      SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
               
                    },
                    text: 'Update',),
              ]),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  if (state is SocialUserUploadLodingState)
                    const LinearProgressIndicator(),
                  if (state is SocialUserUploadLodingState)
                    const SizedBox(
                      height: 10,
                    ),
                  SizedBox(
                    height: 220,
                    child: Stack(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                height: 180,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage('${userModel.cover}')
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 17,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: const Icon(
                                    IconBroken.camera,
                                    color: Colors.black,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 47,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  SocialCubit.get(context).profileImage == null
                                      ? NetworkImage('${userModel.image}')
                                      : FileImage(profileImage!)
                                          as ImageProvider,
                            ),
                            CircleAvatar(
                              radius: 17,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon: const Icon(
                                    IconBroken.camera,
                                    color: Colors.black,
                                    size: 16,
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (profileImage != null || coverImage != null)
                    const SizedBox(
                      height: 10,
                    ),
                  if (profileImage != null || coverImage != null)
                    Row(
                      children: [
                        if (profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                myButtons(
                                  label: 'Update Profile',
                                  onPressed: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                ),
                                
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                myButtons(
                                  label: 'Update Cover',
                                  onPressed: () {
                                    SocialCubit.get(context).uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  defaultFormField3(
                    context: context,
                    prefix: IconBroken.user,
                    label: 'name',
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty ';
                      }
                      return null;
                    },
                  ),
                  defaultFormField3(
                    context: context,
                    prefix: IconBroken.infoCircle,
                    label: 'bio',
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'bio must not be empty ';
                      }
                      return null;
                    },
                  ),
                  defaultFormField3(
                    context: context,
                    prefix: IconBroken.call,
                    label: 'phone',
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'phone must not be empty ';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

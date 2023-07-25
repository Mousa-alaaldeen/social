// ignore_for_file: avoid_print, unused_local_variable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/comment_model.dart';
import 'package:social/models/post_model.dart';
import 'package:social/models/user_model.dart';
import 'package:social/modules/home/home.dart';
import 'package:social/shared/components/constantes.dart';

import '../../models/chat_model.dart';
import '../../modules/chat/chat.dart';
import '../../modules/setting/setting.dart';
import '../../modules/upload/upload.dart';
import '../../modules/users/users.dart';
import '../../shared/network/local/cache_helper.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  bool isDarke = false;
  void appChangeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDarke = fromShared;
    } else {
      isDarke = !isDarke;
    }
    CacheHelper.saveData(key: 'isDark', value: isDarke).then((value) => {
          emit(AppChangeModeState()),
        });
  }

  List<Widget> widgetScreen = [
    const HomeScreen(),
    const ChatScreen(),
    UploadScreen(),
    const UsersScreen(),
    const SettingScreen(),
  ];
  int currentIndex = 0;
  void changeBottom(int index) {
    if (index == 2) {
      emit(NavigateToPostScreenState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavState());
    }
  }

  UserModel? model;
  void getUserData() {
    emit(SocialGetUserLodingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());

      model = UserModel.fromJson(value.data()!);
      emit(SocialGetUserLodingState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  File? coverImage;
  var picker = ImagePicker();
  Future<void> getCoverImage() async {
    final pickerImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickerImage != null) {
      coverImage = File(pickerImage.path);
      emit(SocialCoverImagePeckerSuccessState());
    } else {
      emit(SocialSocialCoverImagePeckerErrorState());
      print('no image selected');
    }
  }

  File? profileImage;

  Future<void> getProfileImage() async {
    final pickerImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickerImage != null) {
      profileImage = File(pickerImage.path);
      print(profileImage);
      emit(SocialCoverImagePeckerSuccessState());
    } else {
      emit(SocialSocialCoverImagePeckerErrorState());
      print('no image selected');
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUploadProfileImageSuccessState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((imageUrl) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          profileImage: imageUrl,
        );
        // removePickedImages();
        //emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      emit(SocialUploadCoverImageSuccessState());
      value.ref.getDownloadURL().then((imageUrl) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          coverImage: imageUrl,
        );
        // removePickedImages();
        //emit(UploadCoverImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // update user info

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? profileImage,
    String? coverImage,
  }) {
    emit(SocialUserUploadLodingState());
    UserModel userModel = UserModel(
      // isEmailVerified: model!.isEmailVerified,
      email: model!.email,
      uId: model!.uId,
      name: name,
      phone: phone,
      bio: bio,
      image: profileImage ?? model!.image,
      cover: coverImage ?? model!.cover,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUploadErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickerImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickerImage != null) {
      postImage = File(pickerImage.path);
      print(profileImage);
      emit(SocialPostImagePeckerSuccessState());
    } else {
      emit(SocialSocialPostImagePeckerErrorState());
      print('no image selected');
    }
  }

  List<int> myCommentsNumber = [];
  List<PostModel> myPostsId = [];
  void getMyPosts() {
    emit(SocialGetPostLodingState());

    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dartTime')
        .snapshots()
        .listen((value) {
      for (var element in value.docs) {
        element.reference
            .collection('likes')
            .orderBy('dartTime')
            .snapshots()
            .listen((value) {
          likesNumber.add(value.docs.length);
          postId.add(element.id);

          myPostsId.add(PostModel.fromJson(element.data()));
        });
      }
      emit(SocialGetPostSuccessState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImagePeckerSuccessState());
  }

  PostModel? postModel;
  void uplodPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatPostLodingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('post/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((imgeUrl) {
        criateNewPost(
          dateTime: dateTime,
          text: text,
          image: imgeUrl,
        );
        emit(SocialCreatPostSuccessState());
      }).catchError((error) {
        emit(SocialCreatPoatErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatPoatErrorState());
    });
  }

  void criateNewPost({
    required String dateTime,
    required String text,
    String? image,
  }) {
    emit(SocialCreatPostLodingState());
    postModel = PostModel(
      name: model!.name,
      uId: model!.uId,
      image: model!.image,
      dartTime: dateTime,
      text: text,
      postImage: image ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel!.toMap())
        .then((value) {
          
      emit(SocialCreatPostSuccessState());
    }).catchError((error) {
      emit(SocialCreatPoatErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likesNumber = [];
  List<CommentModel> comments = [];
  List<int> numberComments = [];

  void getPost() {
   
    print('comments');
    print(comments.length);
    emit(SocialGetPostLodingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dartTime')
        .snapshots()
        .listen((value) {
      for (var element in value.docs) {
     
        element.reference
            .collection('likes')
            .orderBy('dartTime')
            .snapshots()
            .listen((value) {
          likesNumber.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        });
      
      }
            posts=[];
      emit(SocialGetPostSuccessState());
    });
  }

  likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePoatErrorState());
    });
  }

  CommentModel? commentModel;
  void createComment({
    required String postId,
    required String text,
    required String dateTime,
  }) {
    emit(CreatCommentLodingState());
    commentModel = CommentModel(
      text: text,
      dateTime: dateTime,
      name: model!.name,
      image: model!.image,
      uId: model!.uId,
    );
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('comments')
        .add(commentModel!.toMap())
        .then((value) {
      emit(CreatCommentSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreatCommentErrorState());
    });
  }

  void getComments({required String postId}) {
    emit(GetCommentLodingState());
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dartTime')
        .snapshots()
        .listen((value) {
      comments = [];
      for (var element in value.docs) {
        comments.add(CommentModel.fromJson(element.data()));
      }
      emit(GetCommentSuccessState());
    });
  }

  List<UserModel> users = [];
  void getUsers() {
    emit(GetAllUsersLodingState());

    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] != model!.uId) {
          users.add(UserModel.fromJson(element.data()));
        }
      }
      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      emit(GettAllUsersErrorState());
    });
  }

  ChatModel? chatModel;

  void sendMessage({
    required String text,
    required String reseiverId,
    required String dateTime,
  }) {
    chatModel = ChatModel(
      dateTime: dateTime,
      reseiverId: reseiverId,
      senderId: model!.uId,
      text: text,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(reseiverId)
        .collection('messages')
        .add(chatModel!.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(reseiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(chatModel!.toMap())
        .then((value) {
      emit(ResiverMessageSuccessState());
    }).catchError((error) {
      emit(ResiverMessageErrorState());
    });
  }

  List<ChatModel> message = [];

  void getMessage({required String reseiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(reseiverId)
        .collection('messages')
        .orderBy('dartTime')
        .snapshots()
        .listen(
      (event) {
        message = [];
        for (var element in event.docs) {
          message.add(ChatModel.fromJson(element.data()));
        }
        emit(GetMessageSuccessState());
      },
    );
  }

  void deletePost({required postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) {
      getPost();
    }).catchError((error) {});
  }
}

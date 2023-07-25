// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social/models/user_model.dart';
import 'package:social/modules/register/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterIntialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  void userRegister({
    required String email,
    required String phone,
    required String name,
    required String password,
  }) {
    emit(RegisterLodingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        email: email,
        phone: phone,
        name: name,
        uId: value.user!.uid,
      );
      // emit(RegisterSuccessState());
    }).
        // ignore: avoid_types_as_parameter_names
        catchError((Error) {
      print(Error.toString);
      emit(RegisterErrorState(Error.toString()));
    });
    
  }

  void userCreate({
    required String email,
    required String phone,
    required String name,
    required String uId,
  }) {
    UserModel userModel = UserModel(
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write you bio....',
      name: name,
      cover:
          'https://t4.ftcdn.net/jpg/02/17/34/67/240_F_217346782_7XpCTt8bLNJqvVAaDZJwvZjm0epQmj6j.jpg',
      image:
          'https://t4.ftcdn.net/jpg/02/17/34/67/240_F_217346796_TSg5VcYjsFxZtIDK6Qdctg3yqAapG7Xa.jpg',
      // isEmailVerified: false,
    );
    emit(UserCreateLodingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      // print(value.user!.email);
      // print(value.user!.uid);
      emit(UserCreateSuccessState());
    }).
        // ignore: avoid_types_as_parameter_names
        catchError((Error) {
      print(Error.toString);
      emit(UserCreateErrorState(Error.toString()));
    });
  }

  bool isPassword = true;
  IconData iconData = Icons.remove_red_eye;
  void passwordVisibility() {
    isPassword = !isPassword;
    iconData = isPassword
        ? iconData = Icons.remove_red_eye
        : Icons.visibility_off_outlined;

    emit(RegisterPasswordIsVisibilityState());
  }
}

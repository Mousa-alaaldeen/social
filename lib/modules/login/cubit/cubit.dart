// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social/modules/login/cubit/states.dart';
import 'package:social/shared/network/local/cache_helper.dart';

import '../../../models/user_model.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitioalState());
  static LoginCubit get(context) => BlocProvider.of(context);
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    CacheHelper.saveData(key: 'uid', value: userCredential.user!.uid);
    UserModel model = UserModel(
      name: userCredential.user!.displayName,
      email: userCredential.user!.email,
      uId: userCredential.user!.uid,
      image: userCredential.user!.photoURL,
      bio: 'write you bio....',
      cover:
          'https://t4.ftcdn.net/jpg/02/17/34/67/240_F_217346782_7XpCTt8bLNJqvVAaDZJwvZjm0epQmj6j.jpg',
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set(model.toMap())
        .then((value) {
      emit(LoginSuccessState(userCredential.user!.uid));
    });
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void userCreate({
    required String email,
    required String phone,
    required String name,
    required String image,
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
      image: image,
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

  void userLogin({required String email, required String password}) {
    emit(LoginLodingState());
    print(';;;');
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('8888888');
      print(value.user!.email);
      print(value.user!.uid);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      print('eeeeeeeeeeeeeee');
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  IconData iconData = Icons.remove_red_eye;
  void passwordVisibility() {
    isPassword = !isPassword;
    iconData = isPassword
        ? iconData = Icons.remove_red_eye
        : Icons.visibility_off_outlined;

    emit(LoginPasswordIsVisibilityState());
  }
}

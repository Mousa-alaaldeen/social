// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, must_be_immutable, unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social/modules/login/cubit/cubit.dart';
import 'package:social/modules/register/register_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../layout/social_layout.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  

  TextEditingController passwordConteoller = TextEditingController();
  TextEditingController emailConteoller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, Object? state) {
          if (state is LoginErrorState) {
            showToast(text: state.error, state: ToastState.eRORR);
          }
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, SocialLayout());
            });
          }
        },
        builder: (BuildContext context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: Stack(
              children: <Widget>[
                Container(
                  height: 650,
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: WaveWidget(
                      config: CustomConfig(
                        gradients: [
                          [Colors.deepOrange, Colors.pinkAccent.shade200],
                          [
                            Colors.orangeAccent.shade200,
                            Colors.pinkAccent.shade200
                          ],
                        ],
                        durations: [19440, 10800],
                        heightPercentages: [0.20, 0.15],
                        blur: MaskFilter.blur(BlurStyle.solid, 10),
                        gradientBegin: Alignment.bottomLeft,
                        gradientEnd: Alignment.topRight,
                      ),
                      waveAmplitude: 0,
                      size: Size(
                        double.infinity,
                        double.infinity,
                      ),
                    ),
                  ),
                ),

                /// -----------------------------------------
                /// Build scrollable content with ListView widget.
                /// -----------------------------------------
                ListView(
                  children: <Widget>[
                    Container(
                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Login",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.akayaKanadaka(
                                  textStyle: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30.0))),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                deffaultFormField(
                                  controller: emailConteoller,
                                  hintText: 'Username',
                                  prefix: Icons.email,
                                  suffix: Icons.check_circle,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your Username ';
                                    }
                                    return null;
                                  },
                                  context: context,
                                ),
                                deffaultFormField(
                                  controller: passwordConteoller,
                                  hintText: 'password',
                                  prefix: Icons.key,
                                  suffix: cubit.iconData,
                                  isPassword: cubit.isPassword,
                                  suffixPressed: () {
                                    cubit.passwordVisibility();
                                  },
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your password';
                                    }
                                    return null;
                                  },
                                  context: context,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: ConditionalBuilder(
                              condition: state is! LoginLodingState,
                              builder: (BuildContext context) =>
                                  SocialLoginButton(
                                backgroundColor: Colors.deepOrange,
                                height: 50,
                                text: 'Login',
                                borderRadius: 20,
                                buttonType: SocialLoginButtonType.generalLogin,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                        email: emailConteoller.text,
                                        password: passwordConteoller.text);
                                  }
                                },
                              ),
                              fallback: (BuildContext context) => const Center(
                                  child: CircularProgressIndicator()),
                            ),
                          ),
                          Text("Forgot your password?",
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("or, continue with"),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                child: SocialLoginButton(
                                  backgroundColor: Colors.blueAccent.shade700,
                                  height: 50,
                                  text: 'Facebook',
                                  borderRadius: 20,
                                  buttonType:
                                      SocialLoginButtonType.generalLogin,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: SocialLoginButton(
                                  backgroundColor: Colors.blueGrey.shade700,
                                  height: 50,
                                  text: 'Email',
                                  borderRadius: 20,
                                  buttonType:
                                      SocialLoginButtonType.generalLogin,
                                  onPressed: () async {
                                  await cubit.signInWithGoogle();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Dont have an account?"),

                              /// -----------------------------------------
                              /// FlatButton signUp .
                              /// -----------------------------------------
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  child: Text(
                                    'Sign up',
                                  ))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

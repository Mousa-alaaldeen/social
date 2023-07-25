// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social/modules/login/login_screen.dart';
import 'package:social/modules/register/cubit/cubit.dart';
import 'package:social/modules/register/cubit/states.dart';
import 'package:social/shared/style/colors.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../layout/social_layout.dart';
import '../../shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController passwordConteoller = TextEditingController();
  TextEditingController emailConteoller = TextEditingController();
  TextEditingController nameConteoller = TextEditingController();
  TextEditingController phoneConteoller = TextEditingController();
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (BuildContext context, Object? state) {
          // if (state is RegisterErrorState) {
          //   showToast(text: state.error, state: ToastState.eRORR);
          // }
          if (state is UserCreateSuccessState) {
            navigateAndFinish(context, const SocialLayout());
          }
        },
        builder: (BuildContext context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            body: Stack(
              children: [
                SizedBox(
                  height: 650,
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: WaveWidget(
                      /// -----------------------------------------
                      /// Set up all configerations with duration and colors.
                      /// -----------------------------------------
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
                        blur: const MaskFilter.blur(BlurStyle.solid, 10),
                        gradientBegin: Alignment.bottomLeft,
                        gradientEnd: Alignment.topRight,
                      ),
                      waveAmplitude: 0,
                      size: const Size(
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
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              navigateTo(context, LoginScreen);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    SizedBox(
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Register",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.akayaKanadaka(
                                    textStyle: const TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30.0))),
                            deffaultFormField(
                              controller: nameConteoller,
                              hintText: 'User name...',
                              prefix: Icons.supervised_user_circle_sharp,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'please enter your name';
                                }
                                return null;
                              },
                              context: context,
                            ),
                            deffaultFormField(
                              controller: emailConteoller,
                              hintText: 'Email...',
                              prefix: Icons.email,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'please enter your email';
                                }
                                return null;
                              },
                              context: context,
                            ),
                            deffaultFormField(
                              controller: passwordConteoller,
                              hintText: 'password...',
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
                            deffaultFormField(
                              controller: phoneConteoller,
                              hintText: 'phone...',
                              prefix: Icons.phone,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'please enter your phone';
                                }
                                return null;
                              },
                              context: context,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: ConditionalBuilder(
                        condition: state is! RegisterLodingState,
                        builder: (BuildContext context) => SocialLoginButton(
                          backgroundColor:orange,
                          height: 50,
                          text: 'Register',
                          borderRadius: 20,
                          buttonType: SocialLoginButtonType.generalLogin,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userRegister(
                                  email: emailConteoller.text,
                                  phone: phoneConteoller.text,
                                  name: nameConteoller.text,
                                  password: passwordConteoller.text);
                            }
                          },
                        ),
                        fallback: (BuildContext context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ),

                    /// -----------------------------------------
                    /// Aligned content to bottom of parent.
                    /// -----------------------------------------
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

// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, non_constant_identifier_names, avoid_print, unused_import, unnecessary_import

import 'package:cubit_form/cubit_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/layout/social_layout.dart';
import 'package:social/modules/login/login_screen.dart';
import 'package:social/shared/network/local/cache_helper.dart';
import 'package:social/shared/network/remote/dio_helper.dart';
import 'package:social/shared/style/theme.dart';

import 'shared/components/constantes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  bool? isDark = CacheHelper.getData(key: 'isDark');
  print('**********************************************************');
  print(uId);
  print('**********************************************');

  late Widget widg;
  if (uId != null) {
    widg = const SocialLayout();
  } else {
    widg = LoginScreen();
  }

  runApp(MyApp(widg, isDark!));
}

class MyApp extends StatelessWidget {
  late Widget Widg;
  final bool isDark;
  MyApp(this.Widg, this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..getPost()
            ..getUserData()
            ..getUsers()
            ..appChangeMode(fromShared: isDark),
        )
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (context, state) => MaterialApp(
          theme: SocialCubit.get(context).isDarke ? darkTheme : lightTheme,
          debugShowCheckedModeBanner: false,
          home: Widg,
        ),
      ),
    );
  }
}

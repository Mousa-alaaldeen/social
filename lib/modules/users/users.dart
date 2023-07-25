// ignore_for_file: prefer_const_constructors, implementation_imports

import 'package:flutter/material.dart';
import 'package:social/shared/style/icon_broken.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Users',
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
        body: Center(child: Text('Users')));
  }
}

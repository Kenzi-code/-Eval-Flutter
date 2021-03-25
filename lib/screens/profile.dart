import 'package:dwm14/components/drawer.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        drawer: DrawerMenu(),
        body: SafeArea(child: Text('Profile')));
  }
}

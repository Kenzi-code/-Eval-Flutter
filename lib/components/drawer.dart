import 'package:dwm14/constants/firebase.dart';
import 'package:dwm14/models/movie.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.yellow),
            child: Row(
              children: [
                Text('Application éclatée de KK'),
              ],
            ),
          ),
          ListTile(
            title: Text('Detail'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/detail',
                  arguments: ItemArguments(text: 'Detail Screen'));
            },
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/profile');
            },
          ),
          ListTile(
            title: Text('Important'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/important');
            },
          ),
          ListTile(
            title: Text('Sign Out',
                style:
                    TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
            onTap: () async {
              await firebaseAuth.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      )),
    );
  }
}

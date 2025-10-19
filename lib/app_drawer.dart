import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Shop'),
            onTap: () {
              Navigator.pushNamed(context, '/shop');
            },
          ),
          ListTile(
            title: Text('Newsstand'),
            onTap: () {
              Navigator.pushNamed(context, '/newsstand');
            },
          ),
          ListTile(
            title: Text('Who we are'),
            onTap: () {
              Navigator.pushNamed(context, '/info');
            },
          ),
          ListTile(title: Text('My Profile'),
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          },),
          ListTile(title: Text('Basket'),
          onTap: () {
            Navigator.pushNamed(context, '/cart');
          },),
        ],
      ),
    );
  }
}

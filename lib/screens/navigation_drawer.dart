import 'package:flutter/material.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => const UserAccountsDrawerHeader(
        accountName: Text('John Doe'),
        accountEmail: Text(''),
        currentAccountPicture: CircleAvatar(
          backgroundImage: NetworkImage(
            'https://picsum.photos/200/300?image=9',
          ),
        ),
        otherAccountsPictures: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(
              'https://picsum.photos/200/300?image=10',
            ),
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(
              'https://picsum.photos/200/300?image=11',
            ),
          ),
        ],
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.indigo,
              Colors.red,
            ],
          ),
        ),
      );

  Widget buildMenuItems(BuildContext context) => Column(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/settings');
            },
          ),
        ],
      );
}

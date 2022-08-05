import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:hotel_san_miguel/screens/home_screen.dart';
import 'package:hotel_san_miguel/screens/login_screen.dart';
import 'package:hotel_san_miguel/screens/user_screen.dart';

import 'package:hotel_san_miguel/model/user_model.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

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

  Widget buildHeader(BuildContext context) => Material(
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const UserScreen(),
            ));
          },
          child: UserAccountsDrawerHeader(
            accountName: Text(
              '${loggedInUser.names} ${loggedInUser.lastName}',
              style: const TextStyle(fontSize: 18.0),
            ),
            accountEmail: Text(
              '${loggedInUser.email}',
              style: const TextStyle(fontSize: 16.0),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.indigo,
                  Colors.red,
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          runSpacing: 8.0,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: ((context) => const HomeScreen()))),
            ),
            ListTile(
              leading: const Icon(Icons.account_tree_outlined),
              title: const Text(
                'Reportes',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () {
                // Navigator.of(context).pushReplacementNamed('/report');
              },
            ),
            const Divider(
              thickness: 1.0,
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(
                'Configuraciones',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () {
                // Navigator.of(context).pushReplacementNamed('/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text(
                'Cerrar Sesión',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: ((context) => const LoginScreen()))),
            ),
          ],
        ),
      );
}

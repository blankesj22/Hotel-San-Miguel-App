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
            title(
              leading: const Icon(Icons.home),
              title: 'Home',
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: ((context) => const HomeScreen()))),
            ),
            title(
              leading: const Icon(Icons.business_rounded),
              title: 'Habitaciones',
            ),
            title(
              leading: const Icon(Icons.co_present_rounded),
              title: 'Clientes',
            ),
            title(
              leading: const Icon(Icons.add_task_rounded),
              title: 'Beneficios',
            ),
            title(
              leading: const Icon(Icons.account_tree_outlined),
              title: 'Reportes',
              onTap: () {
                // Navigator.of(context).pushReplacementNamed('/report');
              },
            ),
            const Divider(
              thickness: 1.0,
            ),
            title(
              leading: const Icon(Icons.settings),
              title: 'Configuraciones',
              onTap: () {
                // Navigator.of(context).pushReplacementNamed('/settings');
              },
            ),
            title(
              leading: const Icon(Icons.exit_to_app),
              title: 'Cerrar Sesión',
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: ((context) => const LoginScreen()))),
            ),
          ],
        ),
      );
}

Widget title({
  required Icon leading,
  required String title,
  void Function()? onTap,
}) {
  return ListTile(
    leading: leading,
    title: Text(
      title,
      style: const TextStyle(fontSize: 16.0),
    ),
    onTap: onTap,
  );
}

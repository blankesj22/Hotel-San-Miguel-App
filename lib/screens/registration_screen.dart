import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';

import 'package:hotel_san_miguel/model/user_model.dart';
import 'package:hotel_san_miguel/screens/home_screen.dart';

import 'package:hotel_san_miguel/widgets/space_interline_s.dart';
import 'package:hotel_san_miguel/widgets/space_interline_xs.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // form key
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final imageController = TextEditingController();
  final namesEditingController = TextEditingController();
  final lastNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //agregar imagen
    final image = SizedBox(
      height: 82,
      width: 82,
      child: Image.asset('assets/images/user.png'),
    );
    //names field
    final namesField = TextFormField(
      autofocus: false,
      controller: namesEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return 'Ingrese sus nombres';
        }
        if (!regex.hasMatch(value)) {
          return 'Ingrese un nombre válido (mín. 3 caracteres)';
        }
        return null;
      },
      onSaved: (value) => namesEditingController.text = value!,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Nombres',
        labelText: 'Nombres',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    //last lastName field
    final lastNameField = TextFormField(
      autofocus: false,
      controller: lastNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Ingrese sus apellidos';
        }
        return null;
      },
      onSaved: (value) => lastNameEditingController.text = value!,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Apellidos',
        labelText: 'Apellidos',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Ingrese su correo electrónico';
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return 'Ingrese un correo electrónico válido';
        }
        return null;
      },
      onSaved: (value) => emailEditingController.text = value!,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'name@gmail.com',
        labelText: 'Correo electrónico',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    //password flied
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{8,}$');
        if (value!.isEmpty) {
          return 'Ingrese su contraseña';
        }
        if (!regex.hasMatch(value)) {
          return 'Ingrese una contraseña válida (mín. 8 caracteres)';
        }
        return null;
      },
      onSaved: (value) => passwordEditingController.text = value!,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: '********',
        labelText: 'Contraseña',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    //confirm password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return "La contraseña no coincide";
        }
        return null;
      },
      onSaved: (value) => confirmPasswordEditingController.text = value!,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: '********',
        labelText: 'Confirmar contraseña',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    //button registration
    final signUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.indigo,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          singUp(emailEditingController.text, passwordEditingController.text);
        },
        child: const Text(
          "Iniciar Sesión",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.indigo,
          ),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
        
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(36.0, 0.0, 36.0, 36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // SizedBox(
                    //     height: 120.0,
                    //     child: Image.asset(
                    //       "assets/images/logo.png",
                    //       fit: BoxFit.contain,
                    //     )),
                    image,
                    const SpaceInterlineXs(),
                    namesField,
                    const SpaceInterlineXs(),
                    lastNameField,
                    const SpaceInterlineXs(),
                    emailField,
                    const SpaceInterlineXs(),
                    passwordField,
                    const SpaceInterlineXs(),
                    confirmPasswordField,
                    const SpaceInterlineS(),
                    signUpButton,
                    const SpaceInterlineXs(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void singUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {
                  postDetailsToFirestore(),
                })
            .catchError((e) {
          Fluttertoast.showToast(
            msg: e!.message,
          );
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case 'ERROR_INVALID_EMAIL':
            Fluttertoast.showToast(
              msg: 'Correo electrónico inválido',
            );
            break;
          case 'ERROR_WRONG_PASSWORD':
            Fluttertoast.showToast(
              msg: 'Contraseña incorrecta',
            );
            break;
          case 'ERROR_USER_NOT_FOUND':
            Fluttertoast.showToast(
              msg: 'Usuario no encontrado',
            );
            break;
          case 'ERROR_USER_DISABLED':
            Fluttertoast.showToast(
              msg: 'Usuario deshabilitado',
            );
            break;
          case 'ERROR_TOO_MANY_REQUESTS':
            Fluttertoast.showToast(
              msg: 'Demasiados intentos fallidos',
            );
            break;
          case 'ERROR_OPERATION_NOT_ALLOWED':
            Fluttertoast.showToast(
              msg: 'Operación no permitida',
            );
            break;
          default:
            Fluttertoast.showToast(
              msg: 'Error desconocido',
            );
            break;
        }
        Fluttertoast.showToast(msg: errorMessage!);
        if (kDebugMode) {
          print(error.code);
        }
      }
    }
  }

  postDetailsToFirestore() async {
    //calleing firestore
    //calling user model
    //sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    //writing all the values to the firestore
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.names = namesEditingController.text;
    userModel.lastName = lastNameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(
      msg: 'Usuario creado correctamente',
    );
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }
}

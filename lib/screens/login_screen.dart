import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kisanmol_app/screens/registration_screen.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = 'login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();
  //editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool circular = false;
  //Firebase auth
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  void validate() {
    if (_formKey.currentState!.validate()) {
      if (kDebugMode) {
        print("Validated");
      }
    } else {
      if (kDebugMode) {
        print("Not validated");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your email");
        }
        //Email validator
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("please enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail, color: Colors.deepOrangeAccent),
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "name@example.com",
        labelText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );

    final passwordField = TextFormField(
      controller: passwordController,
      obscureText: !isPasswordVisible,
      validator: (value) {
        //Password validator
        RegExp regex = RegExp(r'^.{6,}$');

        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter a valid password min of 6 character");
        }

        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon:
            const Icon(Icons.lock_sharp, color: Colors.deepOrangeAccent),
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "Password",
        suffixIcon: IconButton(
          icon: isPasswordVisible
              ? const Icon(Icons.visibility_off, color: Colors.deepOrangeAccent)
              : const Icon(Icons.visibility, color: Colors.black45),
          onPressed: () =>
              setState(() => isPasswordVisible = !isPasswordVisible),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );

    final loginButton = Material(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.teal,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          minWidth: MediaQuery.of(context).size.width,
          child: const Text('Login',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16)),
          onPressed: () async {
            validate();
            AuthService()
                .signInWithEmailAndPassword(
                    emailController.text, passwordController.text)
                .whenComplete(() => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) => const HomePage()),
                    ));
          }),
    );

    //Google SignIn Button
    final googleSignInButton = ButtonTheme(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              minimumSize: const Size(double.infinity, 48.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0))),
          label: const Text('Continue with Google',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 16)),
          onPressed: () {
            AuthService().signInWithGoogle(context).whenComplete(() =>
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => const HomePage()),
                    (route) => true));
          },
          icon: const FaIcon(
            FontAwesomeIcons.google,
            color: Colors.deepOrangeAccent,
          )),
    );

    //Facebook Login
    final facebookLoginButton = ButtonTheme(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent,
            minimumSize: const Size(double.infinity, 48.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
        label: const Text('Continue with Facebook',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16)),
        onPressed: () {
          AuthService().signInWithFacebook(context).whenComplete(() =>
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => const HomePage()),
                  (route) => false));
        },
        icon: const FaIcon(
          FontAwesomeIcons.facebook,
          color: Colors.white,
        ),
      ),
    );

    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background1.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white,
                  BlendMode.darken,
                ))),
        child: Padding(
          padding: const EdgeInsets.all(21.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    height: 180, child: Image.asset('assets/images/logo.png')),
                const SizedBox(
                  height: 40,
                ),
                emailField,
                const SizedBox(
                  height: 15,
                ),
                passwordField,
                const SizedBox(
                  height: 20,
                ),
                loginButton,
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  '⎯⎯⎯⎯⎯⎯⎯⎯ or⎯⎯⎯⎯⎯⎯⎯⎯',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 15,
                ),
                googleSignInButton,
                const SizedBox(
                  height: 10,
                ),
                facebookLoginButton,
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      const RegistrationScreen()));
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.deepOrange,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    )));
  }
}

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisanmol_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:kisanmol_app/services/user_management.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String id = 'splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget currentPage = const LoginScreen();
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  late StreamSubscription<User?> user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (builder) => UserManagement().handleAuth()),
      ),
    );
      if (user == null) {
        if (kDebugMode) {
          print('User is currently signed out !');
        }
      } else {
        if (kDebugMode) {
          print('User is signed in !');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 300.0,
                  width: 300.0,
                ),
                Text(
                  "A whole garden at your fingertips",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.hurricane(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                  ),
                ),
              ],
            ),
            const CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisanmol_app/services/user_management.dart';
import 'package:splash_view/splash_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String id = 'splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final firebaseAuth = FirebaseAuth.instance;
  late StreamSubscription<User?> user;
   final Color primaryColor=const Color(0xff109480);

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      Timer(
      const Duration(seconds: 5),
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
      backgroundColor: primaryColor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 500.0,
                  width: 500.0,
                ),
                Text(
                  "A whole garden at your fingertips",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.hurricane(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

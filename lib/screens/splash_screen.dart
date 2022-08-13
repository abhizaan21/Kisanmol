import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisanmol_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:kisanmol_app/screens/registration_screen.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String id = 'splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget currentPage = const LoginScreen();
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  late StreamSubscription<User?> user;

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (builder) => checkRoute()),
      ),
    );
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
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
    checkLogin();
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  checkLogin() async {
    String? token = await AuthService().getToken();
    if (kDebugMode) {
      print(token);
    }
    if (token != null) {
      setState(() {
        currentPage = const HomePage();
      });
    }
  }

  checkRoute() {
    return MaterialApp(
      initialRoute:
          firebaseAuth.currentUser == null ? LoginScreen.id : HomePage.id,

      ///key value pair
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        HomePage.id: (context) => const HomePage(),
      },
      home: currentPage,
    );
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

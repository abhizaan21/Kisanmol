import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisanmol_app/screens/home_screen.dart';
import 'package:kisanmol_app/screens/login_screen.dart';
import 'package:kisanmol_app/screens/registration_screen.dart';
import 'package:kisanmol_app/services/auth_service.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthClass authClass = AuthClass();
  Widget currentPage = const IntroScreen();
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  late StreamSubscription<User?> user;

  @override
  void initState() {
    checkLogin();
    super.initState();
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
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  checkLogin() async {
    String? token = await authClass.getToken();
    if (kDebugMode) {
      print("token");
    }
    if (token != null) {
      setState(() {
        currentPage = const HomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? LoginScreen.id
          : HomePage.id,

      ///key value pair
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        HomePage.id: (context) => const HomePage(),
      },
      home: currentPage,
    );
  }
}

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        useLoader: true,
        loadingText: const Text(""),
        navigateAfterSeconds: const LoginScreen(),
        seconds: 2,
        title: Text(
          'Kisanmol',
          style: GoogleFonts.calligraffitti(
              fontSize: 35,
              fontWeight: FontWeight.w600,
              color: Colors.deepOrangeAccent),
        ),
        image: Image.asset('assets/images/Logo1.png', fit: BoxFit.scaleDown),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: const TextStyle(),
        photoSize: 121,
        loaderColor: Colors.deepOrangeAccent);
  }
}

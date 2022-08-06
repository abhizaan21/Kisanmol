import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kisanmol_app/screens/home_screen.dart';
import 'package:kisanmol_app/screens/login_screen.dart';

import '../utils/resource.dart';

class AuthService {
  final FirebaseAuth _auth;
  AuthService(this._auth);

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Stream<User?> get authStateChanges => FirebaseAuth.instance.idTokenChanges();

  final storage = const FlutterSecureStorage();
  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication =
      await googleSignInAccount?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      if (googleSignInAccount != null) {
        UserCredential userCredential =
        await _auth.signInWithCredential(credential);
        storeTokenAndData(userCredential);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => const HomePage()),
                (route) => false);

        const snackBar = SnackBar(content: Text("Logged In Successfully"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Log In failed");
      }
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }



  Future<Resource?> signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);
          final userCredential =
          await _auth.signInWithCredential(facebookCredential);
          storeTokenAndData(userCredential);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => const HomePage()),
                  (route) => false);
          return Resource(status: Status.success);
        case LoginStatus.cancelled:
          return Resource(status: Status.cancelled);
        case LoginStatus.failed:
          return Resource(status: Status.error);
        default:
          return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      FirebaseAuth.instance.signOut();
      await _googleSignIn.signOut();
      await _auth.signOut();
      await storage.delete(key: "token");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const LoginScreen()),
              (route) => false);

      const snackBar = SnackBar(content: Text("Logged Out"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      const snackBar = SnackBar(content: Text("Error occurred"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void storeTokenAndData(UserCredential userCredential) async {
    if (kDebugMode) {
      print("storing token and data");
    }
    await storage.write(
        key: "token", value: userCredential.credential?.token.toString());
    await storage.write(
        key: "usercredential", value: userCredential.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  void showSnackBar(BuildContext context, String text) {
    const snackBar = SnackBar(content: Text("Failed"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
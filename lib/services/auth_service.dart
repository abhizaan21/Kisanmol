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
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
  );
  final storage = const FlutterSecureStorage();
  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();
  Stream<String?> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
      (User? user)=> user?.uid);

  // GET UID
  Future<String?> getCurrentUID() async {
    return (_firebaseAuth.currentUser)?.uid;
  }

  // Email & Password Sign Up
  Future<User?> signUp(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: email);
      User? user = result.user;
      return Future.value(user);
      // return Future.value(true);
    } catch (e) {
      if (kDebugMode) {
        print("Sign up failed");
      }
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return Future.value(null);
  }
  // Email & Password Sign In
  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        ?.uid;
  }

  Future convertUserWithEmail(
      String email, String password, String name) async {
    final currentUser = _firebaseAuth.currentUser!;

    final credential =
        EmailAuthProvider.credential(email: email, password: password);
    await currentUser.linkWithCredential(credential);
  }

  Future convertWithGoogle() async {
    final currentUser = _firebaseAuth.currentUser!;
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? _googleAuth =
        await account?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: _googleAuth?.idToken,
      accessToken: _googleAuth?.accessToken,
    );
    await currentUser.linkWithCredential(credential);
  }

  // GOOGLE
  Future<void> signInWithGoogle(BuildContext context) async {
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
        await _firebaseAuth.signInWithCredential(credential);
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
              await _firebaseAuth.signInWithCredential(facebookCredential);
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
      await _firebaseAuth.signOut();
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ],
  );
  final storage = const FlutterSecureStorage();
  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();
  Stream<String?> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().map((User? user) => user?.uid);

  // GET UID
  Future<String?> getCurrentUID() async {
    return (_firebaseAuth.currentUser)?.uid;
  }

  // Email & Password Sign Up
  Future<User?> signUp(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return Future.value(user);
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Future.value(null);
    }
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
    final GoogleSignInAuthentication? googleAuth =
        await account?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken,
      accessToken: googleAuth?.accessToken,
    );
    await currentUser.linkWithCredential(credential);
  }

  // GOOGLE Sign In
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication?.accessToken,
          idToken: googleSignInAuthentication?.idToken);

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      User user = _firebaseAuth.currentUser!;
      if (kDebugMode) {
        print(user.uid);
      }
      storeTokenAndData(userCredential);
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final checkUsers = await users.doc(googleSignInAccount?.id).get();
      if (checkUsers.exists) {
        users.doc(googleSignInAccount?.id).set({
          'uid': userCredential.user?.uid,
          'name': googleSignInAccount?.displayName,
          'email': googleSignInAccount?.email,
          'photo': googleSignInAccount?.photoUrl,
          'createdAt': userCredential.user?.metadata.creationTime.toString(),
          'lastLogin': userCredential.user?.metadata.lastSignInTime.toString(),
        });
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      FirebaseAuth.instance.signOut();
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      await storage.delete(key: "token");
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

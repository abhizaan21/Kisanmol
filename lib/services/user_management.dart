import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kisanmol_app/screens/first_view.dart';
import 'package:kisanmol_app/screens/login_screen.dart';
import 'package:kisanmol_app/services/auth_service.dart';
import 'package:flutter/widgets.dart';

class UserManagement {
  static String id = 'userManagement';
  Widget handleAuth() {
     return StreamBuilder(
      stream: AuthService().onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return authorizeAccess(context);
        }
        return const FirstView();
      }
    );
  }

  authorizeAccess(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == currentUser) {
      FirebaseFirestore.instance
          .collection("users")
          .where('uid', isEqualTo: currentUser?.uid)
          .get()
          .then((checkSnapshot) {
        if (checkSnapshot.docs[0].exists) {
          if (checkSnapshot.docs[0].data()['role'] == 'Seller') {
            Get.offNamed('/sellerScreen');
          } else {
            Get.offNamed('/buyerScreen');
          }
        }
      });
    }
  }
}

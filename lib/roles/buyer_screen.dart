import 'package:flutter/material.dart';
import '../screens/daily_fresh.dart';
import '../screens/fresh_crops.dart';
import '../screens/recommended.dart';
import '../screens/search_box.dart';
import '../services/auth_service.dart';
import '../widgets/constants.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class BuyerPage extends StatelessWidget {
  final firebase_auth.FirebaseAuth firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

  BuyerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              ///Add menu drop down function
            },
            icon: const Icon(
              Icons.menu,
              size: 25,
              color: Colors.deepOrangeAccent,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: appPadding),
            child: IconButton(
                onPressed: () {
                  AuthService(firebase_auth.FirebaseAuth.instance)
                      .signOut(context);
                },
                icon: const Icon(
                  Icons.logout,
                  color: kBackgroundColor,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SearchBox(),
            DailyFresh(),
            Recommended(),
            FreshCrops(),
          ],
        ),
      ),
    );
  }
}

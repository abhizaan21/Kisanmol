import 'package:flutter/material.dart';
import 'package:kisanmol_app/widgets/menu_drawer_widget.dart';
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
      drawer: const MenuDropWidget(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kBackgroundColor),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: appPadding),
            child: IconButton(
                onPressed: () {
                  AuthService()
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

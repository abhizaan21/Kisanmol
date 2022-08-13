import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kisanmol_app/screens/crop_details_submit.dart';
import '../services/auth_service.dart';
import '../widgets/constants.dart';
import '../widgets/menu_drawer_widget.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SellerPage extends StatefulWidget {
  const SellerPage({Key? key}) : super(key: key);

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  final CollectionReference crops =
      FirebaseFirestore.instance.collection('crops');
  final firebase_auth.FirebaseAuth firebaseAuth =
      firebase_auth.FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {

    final uploadButton = ButtonTheme(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              primary: Colors.teal,
              minimumSize: const Size(double.infinity, 48.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0))),
          label: const Text('Add crop details',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16)),
          onPressed: () { Navigator.pushAndRemoveUntil(
              (context),
              MaterialPageRoute(builder: (context) => const SubmitDetail()),
                  (route) => false);},
          icon: const FaIcon(
            FontAwesomeIcons.upload,
            color: Colors.white,
          )),
    );

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
        child: Form(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    height: 150, child: Image.asset('assets/icons/crops.png')),
                 const SizedBox(
                  height: 40,
                ),
                uploadButton,
              ]),
        ),
      ),
    );
}}

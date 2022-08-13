import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisanmol_app/models/user_model.dart';
import 'package:kisanmol_app/roles/buyer_screen.dart';
import 'package:kisanmol_app/roles/seller_screen.dart';
import 'package:kisanmol_app/widgets/constants.dart';

class HomePage extends StatefulWidget {
  static String id = 'homepage';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState()=> _HomePageState();}

class _HomePageState extends State<HomePage>{

  User? user=FirebaseAuth.instance.currentUser;
  UserModel loggedInUser=UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final buyerLogin = Material(
      borderRadius: BorderRadius.circular(21.0),
      color: Colors.teal,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          minWidth: MediaQuery.of(context).size.width * 0.9,
          child: const Text('Login as crop buyer',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16)),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => BuyerPage()),
                (route) => false);
          }),
    );
    final sellerLogin = Material(
      borderRadius: BorderRadius.circular(21.0),
      color: Colors.teal,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          minWidth: MediaQuery.of(context).size.width * 0.9,
          child: const Text('Login as a crop seller',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16)),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => const SellerPage()),
                    (route) => false);
          }),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(
          "Kisanmol",
          style: GoogleFonts.lateef(
              color: white, fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background2.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black12,
                      BlendMode.darken,
                    ))),
            child: Padding(
              padding: const EdgeInsets.all(21.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 21,
                    ),
                    SizedBox(
                      child: Text(
                          "Sell your goods all over india and find a best match for your crops. !",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aleo(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    buyerLogin,
                    const SizedBox(
                      height: 15,
                    ),
                    sellerLogin,
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

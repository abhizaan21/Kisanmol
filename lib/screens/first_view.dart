import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisanmol_app/widgets/constants.dart';

class FirstView extends StatefulWidget {
  const FirstView({Key? key}) : super(key: key);
  static String id = 'firstView';
  @override
  State<FirstView> createState() => _FirstViewState();
}

class _FirstViewState extends State<FirstView> {

  @override
  Widget build(BuildContext context) {
    final buyerLogin = Material(
      borderRadius: BorderRadius.circular(21.0),
      color: Colors.teal,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          minWidth: MediaQuery.of(context).size.width * 0.9,
          child: const Text('Sign up as crop buyer',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16)),
          onPressed: () {
            Get.offNamed('/buyerRegister');
          }),
    );
    final sellerLogin = Material(
      borderRadius: BorderRadius.circular(21.0),
      color: Colors.teal,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          minWidth: MediaQuery.of(context).size.width * 0.9,
          child: const Text('Sign up as a crop seller',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16)),
          onPressed: () {
            Get.offNamed('/sellerRegister');
          }),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(
          "KisanDai",
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 180,
                        child: Image.asset('assets/icons/crops.png')),
                    SizedBox(
                      child: Text(
                          "Buy and sell goods in Butwal city and find a best match for your Taste Buds. !",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.offNamed('/login');
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.deepOrange,
                              ),
                            ))
                      ],
                    )
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

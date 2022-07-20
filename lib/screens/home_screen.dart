import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation:0,
        title: const Text("Welcome"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.logout_rounded,
              size: 20,
              color: Colors.deepOrange,
            ),alignment: Alignment.topRight,),
      ),
      body:  Center(
        child: Padding(padding: const EdgeInsets.all(21),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 121,
                child: Image.asset("assets/images/homeimg1.jpg",fit:BoxFit.contain),

            ), Text('Here you are',style: GoogleFonts.cuteFont(fontSize: 21,fontWeight:FontWeight.bold),)
          ],
        ),),
      ),
    );
  }
}

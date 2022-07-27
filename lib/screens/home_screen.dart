import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisanmol_app/screens/login_screen.dart';
import '../services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = 'homepage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          actions: [
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await authClass.signOut(context: context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const LoginScreen()),
                      (route) => false);
                  const snackBar = SnackBar(content: Text("Logged Out"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }),
          ],
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/homeimg1.jpg'),
            const SizedBox(
              height: 20,
            ),
            Text("${FirebaseAuth.instance.currentUser!.displayName}"),
            Text("${FirebaseAuth.instance.currentUser!.email}"),
            const SizedBox(
              height: 20,
            ),ButtonTheme(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: ElevatedButton.icon(style: ElevatedButton.styleFrom(
                primary: Colors.deepOrangeAccent,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0))),
              label: const Text('Log Out',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              onPressed: () async {
                await authClass.signOut(context: context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              }, icon: const Icon(Icons.logout),
            )),
          ],
        )));
  }
}

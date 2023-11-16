import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/chat_page.dart';
import '../screens/login_screen.dart';
import '../services/auth_service.dart';

class MenuDrawerWidget extends StatelessWidget {
  MenuDrawerWidget({Key? key}) : super(key: key);
  late final  currentAccount = FirebaseAuth.instance.currentUser;
  final db = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 220,
        child: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              Container(
                decoration:BoxDecoration(color: Colors.teal.shade400),
                height: 56,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FittedBox(
                      child: Text(
                        currentAccount!.email.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Your Crops'),
                onTap: () async {
                  ///display crop data
                },
              ),
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text('Inbox'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyChatPage(),
                      ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () {
                  AuthService().signOut(context).whenComplete(
                      () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

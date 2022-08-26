import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kisanmol_app/pages/present_messages.dart';

import '../widgets/constants.dart';

class MyChatPage extends StatefulWidget {
  const MyChatPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyChatPage> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<MyChatPage> {
  final setMessage = FirebaseFirestore.instance;
  var currentAccount = FirebaseAuth.instance.currentUser;
  final db = FirebaseAuth.instance;
  getUser() {
    final user = db.currentUser;
    if (user != null) {
      currentAccount = user;
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text('Messages'),
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 25),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                  height: 300,
                  child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      reverse: true,
                      child: Messages())),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: message,
                    decoration:
                        const InputDecoration(hintText: 'Enter Message'),
                  )),
                  IconButton(
                      onPressed: () {
                        if (message.text.isNotEmpty) {
                            setMessage.collection('message').doc().set({
                            "msg": message.text.trim(),
                            "user": currentAccount!.email.toString(),
                            "time": DateTime.now(),
                          });
                        }
                        message.clear();
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
            ],
          ),
        ));
  }
}

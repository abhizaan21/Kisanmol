import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  var currentAccount = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .orderBy("time")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              primary: true,
              reverse: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, i) {
                QueryDocumentSnapshot m = snapshot.data!.docs[i];
                return Card(
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: currentAccount!.email == m["user"]
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.start,
                      children: [
                        Text(m["msg"],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                        Text(m["user"])
                      ],
                    ),
                  ),
                );
              });
        });
  }
}

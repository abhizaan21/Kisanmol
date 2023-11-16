import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kisanmol_app/widgets/menu_drawer_widget.dart';
import '../models/crop_model.dart';
import '../services/auth_service.dart';
import '../widgets/constants.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class BuyerPage extends StatelessWidget {
  final firebase_auth.FirebaseAuth firebaseAuth =
      firebase_auth.FirebaseAuth.instance;
  static String id = 'buyerPage';

  BuyerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MenuDrawerWidget(),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey.shade400,
        appBar: AppBar(
          title: const Text('Available Crops',style: TextStyle(color: Colors.white),),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0.0,
          backgroundColor: kPrimaryColor,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: appPadding),
              child: IconButton(
                  onPressed: () {
                    ///add chat page
                  },
                  icon: const Icon(
                    Icons.message,
                    color: Colors.white,
                  )),
            )
          ],
        ),
        body: Center(
            child: StreamBuilder(
                stream: getUsersCropsStreamSnapshots(context),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    if (kDebugMode) {
                      print('Loading.....');
                    }
                    return const Center(child: CircularProgressIndicator());
                  }
                  final int? cropCount = snapshot.data?.docs.length;
                  return ListView.builder(
                      itemCount: cropCount,
                      itemBuilder: (BuildContext context, int index) =>
                          buildCropCard(context, snapshot.data!.docs[index]));
                }
            )));
  }

  Stream<QuerySnapshot>getUsersCropsStreamSnapshots(BuildContext context) async*{
    final uid= await AuthService().getCurrentUID();
    if (kDebugMode) {
      print(uid);
    }
    yield* FirebaseFirestore.instance.collection('cropsData').snapshots();
  }

  Widget buildCropCard(BuildContext context, DocumentSnapshot document ) {
    final crop=CropModel.fromSnapshot(document);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.6),
            offset: const Offset(30.0, 30.0),
            blurRadius: 15,
          ),
        ],
      ),

      child: Card(
        elevation: 30.0,
        color:Colors.orange.shade600,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  Text(
                    (crop.type.toString()),
                    style: const TextStyle(fontSize: 30.0,color:Colors.white),
                  ),
                  const Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  const Text('User ID:',
                      style:  TextStyle(fontSize: 15.0,color:Colors.white)),
                  const Spacer(),
                  Text((crop.uid.toString()),
                      style:  const TextStyle(fontSize: 15.0,color:Colors.white)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  const Text('Location:',
                      style:  TextStyle(fontSize: 15.0,color:Colors.white)),
                  const Spacer(),
                  Text((crop.location.toString().toUpperCase()),
                      style:  const TextStyle(fontSize: 15.0,color:Colors.white)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  const Text('Requirement:',
                      style:  TextStyle(fontSize: 15.0,color:Colors.white)),
                  const Spacer(),
                  Text(('${crop.requirement.toString()} Boxes'),
                      style:  const TextStyle(fontSize: 15.0,color:Colors.white)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  const Text('Grade A:',
                      style:  TextStyle(fontSize: 15.0,color:Colors.white)),
                  const Spacer(),
                  Text(('\$${crop.gradeA.toString()} /Boxes'),
                      style: const TextStyle(fontSize: 15.0,color:Colors.white)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  const Text('Grade B:',
                      style:  TextStyle(fontSize: 15.0,color:Colors.white)),
                  const Spacer(),
                  Text(('\$${crop.gradeB.toString()} /Boxes'),
                      style: const TextStyle(fontSize: 15.0,color:Colors.white)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.date_range_outlined,color: Colors.white,),
                    const Spacer(),
                    Text(crop.lastUpdated.toString(),
                        style: const TextStyle(fontSize: 15.0,color:Colors.white))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

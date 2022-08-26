import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kisanmol_app/screens/crop_details_submit.dart';
import 'package:kisanmol_app/services/auth_service.dart';
import '../models/crop_model.dart';
import '../widgets/constants.dart';
import '../widgets/menu_drawer_widget.dart';

class SellerPage extends StatefulWidget {
  const SellerPage({Key? key}) : super(key: key);

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MenuDrawerWidget(),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey.shade400,
        appBar: AppBar(
          centerTitle: true,
          title:
              const Text('Your Crops', style: TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0.0,
          backgroundColor: Colors.teal.shade400,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  (context),
                  MaterialPageRoute(
                    builder: (context) => const SubmitDetail(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
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
                })));
  }

  Stream<QuerySnapshot> getUsersCropsStreamSnapshots(
      BuildContext context) async* {
    final uid = await AuthService().getCurrentUID();
    if (kDebugMode) {
      print(uid);
    }
    yield* FirebaseFirestore.instance
        .collection('cropsData')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  Widget buildCropCard(BuildContext context, DocumentSnapshot document) {
    final crop = CropModel.fromSnapshot(document);

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
        color: Colors.orange.shade600,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  Text(
                    (crop.type.toString()),
                    style: const TextStyle(fontSize: 30.0, color: Colors.white),
                  ),
                  const Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  const Text('User ID:',
                      style: TextStyle(fontSize: 15.0, color: Colors.white)),
                  const Spacer(),
                  Text((crop.uid.toString()),
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.white)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  const Text('UserName:',
                      style: TextStyle(fontSize: 15.0, color: Colors.white)),
                  const Spacer(),
                  Text((crop.userName.toString().toUpperCase()),
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.white)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  const Text('Requirement:',
                      style: TextStyle(fontSize: 15.0, color: Colors.white)),
                  const Spacer(),
                  Text(('${crop.requirement.toString()} Boxes'),
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.white)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  const Text('Grade A:',
                      style: TextStyle(fontSize: 15.0, color: Colors.white)),
                  const Spacer(),
                  Text(('\$${crop.gradeA.toString()} /Boxes'),
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.white)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  const Text('Grade B:',
                      style: TextStyle(fontSize: 15.0, color: Colors.white)),
                  const Spacer(),
                  Text(('\$${crop.gradeB.toString()} /Boxes'),
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.white)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.date_range_outlined,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    Text(crop.lastUpdated.toString(),
                        style: const TextStyle(
                            fontSize: 15.0, color: Colors.white))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          primary: kPrimaryColor.shade400,),
                        onPressed: () async {
                          await FirebaseFirestore.instance.runTransaction(
                              (transaction) async =>
                                  transaction.delete(document.reference));
                        },
                        child: const Text('Delete',
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.white))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../roles/seller_screen.dart';
import '../services/auth_service.dart';

class SubmitDetail extends StatefulWidget {
  const SubmitDetail({Key? key}) : super(key: key);
  static String id = 'registration';
  @override
  State<SubmitDetail> createState() => _SubmitDetail();
}

class _SubmitDetail extends State<SubmitDetail> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  //form key
  final _formKey = GlobalKey<FormState>();

  final TextEditingController userNameEditingController =
      TextEditingController();
  final TextEditingController requirementEditingController =
      TextEditingController();
  final TextEditingController gradeAEditingController = TextEditingController();
  final TextEditingController gradeBEditingController = TextEditingController();
  final TextEditingController typeEditingController = TextEditingController();
  final TextEditingController lastUpdatedEditingController =
      TextEditingController();
  bool circular = false;
  bool isPasswordVisible = false;
  final db = FirebaseFirestore.instance.collection('cropDetails');

  @override
  Widget build(BuildContext context) {
    //Start of the creation of the field for different input type

    final userNameField = TextFormField(
      controller: userNameEditingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        //Name validator
        if (value!.isEmpty) {
          return ("This field cannot be empty");
        } else {
          return null;
        }
      },
      onSaved: (value) {
        userNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.person, color: Colors.deepOrangeAccent),
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "Username",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );

    final requirementField = TextFormField(
      controller: requirementEditingController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("This field cannot be empty");
        }
        return null;
      },
      onSaved: (value) {
        requirementEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person, color: Colors.deepOrangeAccent),
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "Requirement",
        labelText: "box quantity",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );

    final gradeAField = TextFormField(
      controller: gradeAEditingController,
      keyboardType: TextInputType.number,
      //email validator
      validator: (value) {
        if (value!.isEmpty) {
          return ("Number is required");
        } else {
          return null;
        }
      },
      onSaved: (value) {
        gradeAEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "500\$",
        labelText: "amount per box",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );

    final gradeBField = TextFormField(
      controller: gradeBEditingController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Number is required");
        } else {
          return null;
        }
      },
      onSaved: (value) {
        gradeBEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "250\$",
        labelText: "amount per box",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );

    final typeField = TextFormField(
      controller: typeEditingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        //Name validator
        if (value!.isEmpty) {
          return ("This field cannot be empty");
        } else {
          return null;
        }
      },
      onSaved: (value) {
        typeEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person, color: Colors.deepOrangeAccent),
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "Type of Crop",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );

    final updatedField = TextFormField(
      controller: lastUpdatedEditingController,
      keyboardType: TextInputType.datetime,
      validator: (value) {
        if (value!.isEmpty) {
          return ("please enter the date and time");
        } else {
          return null;
        }
      },
      onSaved: (value) {
        lastUpdatedEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person, color: Colors.deepOrangeAccent),
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        hintText: "'MM/dd/yyyy'",
        labelText: "Today's Date",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );

    //End of the fields creation

    //SignUp Button
    final submitDetails = Material(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.teal,
        child: MaterialButton(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            minWidth: MediaQuery.of(context).size.width,
            child: const Text('Submit crop details',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16)),
            onPressed: () async {
              var uid = await AuthService().getCurrentUID();
              //save cropDetails to firebase
              Map<String, dynamic> data = {
                'uid': uid,
                'userName': userNameEditingController.text,
                'requirement': requirementEditingController.text,
                'gradeA': gradeAEditingController.text,
                'gradeB': gradeBEditingController.text,
                'type': typeEditingController.text,
                'lastUpdated': lastUpdatedEditingController.text,
              };
               await db.add(data);
              Fluttertoast.showToast(msg: "Crop details submitted successfully !");
              Navigator.pushAndRemoveUntil(
                  (context),
                  MaterialPageRoute(builder: (context) => const SellerPage()),
                      (route) => false);
            }));

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text("Kisanmol",
            style: GoogleFonts.lateef(
                color: Colors.deepOrangeAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const SellerPage()));
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 35,
              color: Colors.deepOrangeAccent,
            )),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/homeImage1.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black12,
                      BlendMode.darken,
                    ))),
            child: Padding(
              padding: const EdgeInsets.all(21.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 21,
                    ),
                    SizedBox(
                      child: Text("Crop details !",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aleo(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    userNameField,
                    const SizedBox(
                      height: 15,
                    ),
                    requirementField,
                    const SizedBox(
                      height: 15,
                    ),
                    gradeAField,
                    const SizedBox(
                      height: 15,
                    ),
                    gradeBField,
                    const SizedBox(
                      height: 15,
                    ),
                    typeField,
                    const SizedBox(
                      height: 25,
                    ),
                    updatedField,
                    const SizedBox(
                      height: 15,
                    ),
                    submitDetails,
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

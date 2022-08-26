import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? role;
  String? companyName;
  String? farmName;

  //Details of user for Email sigIn
  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.secondName,
      this.role,
      this.companyName,
      this.farmName});

  //Sending data to the server
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'firstName': firstName,
        'secondName': secondName,
        'role': role,
        'companyName': companyName,
        'farmName': farmName
      };
  //Data from the server
  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot['uid'],
        email = snapshot['email'],
        firstName = snapshot['firstName'],
        secondName = snapshot['secondName'],
        role = snapshot['role'],
        companyName = snapshot['companyName'],
        farmName = snapshot['farmName'];
}

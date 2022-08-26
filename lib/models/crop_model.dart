import 'package:cloud_firestore/cloud_firestore.dart';

class CropModel {
  String? uid;
  String? userName;
  String? requirement;
  String? gradeA;
  String? gradeB;
  String? type;
  DateTime? lastUpdated;

  CropModel(
      this.uid,
      this.userName,
      this.requirement,
      this.gradeA,
      this.gradeB,
      this.type,
      this.lastUpdated);

  //Sending data to the server
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'userName': userName,
        'requirement': requirement,
        'gradeA': gradeA,
        'gradeB': gradeB,
        'type': type,
        'lastUpdated': lastUpdated,
      };

  // creating a crop object from a firebase snapshot
  CropModel.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot['uid'],
        userName = snapshot['userName'],
        requirement = snapshot['requirement'],
        gradeA = snapshot['gradeA'],
        gradeB = snapshot['gradeB'],
        type = snapshot['type'],
        lastUpdated = DateTime.parse(snapshot['lastUpdated'].toDate().toString());
}

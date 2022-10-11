import 'package:cloud_firestore/cloud_firestore.dart';

class WeightModel {
  String? id;
  String? weight;
  Timestamp? timeStamp;

  WeightModel({this.id, this.weight, this.timeStamp});

  WeightModel.fromMap(Map snapshot, String docId)
      : id = docId,
        weight = snapshot['weight'],
        timeStamp = snapshot['timeStamp'];

  toJson() {
    return {"weight": weight, "timeStamp": timeStamp};
  }
}

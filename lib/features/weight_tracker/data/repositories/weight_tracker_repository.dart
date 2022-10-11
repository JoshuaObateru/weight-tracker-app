import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/data/models/weight_model.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/services/firebase_firestore_service.dart';

class WeightTrackerRepository {
  final FirebaseFirestoreService firebaseFirestoreService;

  WeightTrackerRepository({required this.firebaseFirestoreService});

  Future<List<WeightModel>> fetchWeights() async {
    var result = await firebaseFirestoreService.getDataCollection();
    return result.docs
        .map((weight) => WeightModel.fromMap(weight.data() as Map, weight.id))
        .toList();
  }

  Stream<QuerySnapshot> fetchWeightsasStream() {
    return firebaseFirestoreService.streamDataCollection();
  }

  Future<WeightModel> getWeightById(String id) async {
    var result = await firebaseFirestoreService.getDocumentById(id);
    return WeightModel.fromMap(result.data() as Map, id);
  }

  Future removeWeight(String id) async {
    await firebaseFirestoreService.removeDocumentById(id);
    return;
  }

  Future updateWeight(WeightModel weight, String id) async {
    await firebaseFirestoreService.updateDocument(weight.toJson(), id);
    return;
  }

  Future addWeight(WeightModel weight) async {
    await firebaseFirestoreService.addDocument(weight.toJson());
    return;
  }
}

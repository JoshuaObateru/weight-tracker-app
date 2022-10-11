import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore firebaseFirestoreDb;
  final FirebaseAuth firebaseAuth;
  final String userPath = "userWeights";
  final String childPath = "weights";
  late String userId;
  late CollectionReference ref;

  FirebaseFirestoreService(
      {required this.firebaseFirestoreDb, required this.firebaseAuth}) {
    userId = firebaseAuth.currentUser!.uid;

    ref = firebaseFirestoreDb
        .collection(userPath)
        .doc(userId)
        .collection(childPath);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.orderBy('timeStamp', descending: true).get();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.orderBy('timeStamp', descending: true).snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocumentById(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map<String, Object> data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map<String, Object> data, String id) {
    return ref.doc(id).update(data);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:obateru_joshua_weight_tracker_app/features/auth/bloc/auth_bloc.dart';
import 'package:obateru_joshua_weight_tracker_app/features/auth/data/repositories/auth_repository.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/bloc/fetch_weights_bloc.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/bloc/weight_tracker_bloc.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/data/repositories/weight_tracker_repository.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/services/firebase_firestore_service.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerFactory(() => AuthBloc(authRepository: sl()));
  sl.registerFactory(() => WeightTrackerBloc(weightTrackerRepository: sl()));
  sl.registerFactory(() => FetchWeightsBloc(weightTrackerRepository: sl()));

  sl.registerLazySingleton(
      () => AuthRepository(firebaseAuth: sl(), googleSignIn: sl()));

  sl.registerLazySingleton(() =>
      FirebaseFirestoreService(firebaseFirestoreDb: sl(), firebaseAuth: sl()));
  sl.registerLazySingleton(
      () => WeightTrackerRepository(firebaseFirestoreService: sl()));

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestoreDb = FirebaseFirestore.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  sl.registerLazySingleton(() => firebaseAuth);

  sl.registerLazySingleton(() => googleSignIn);
  sl.registerLazySingleton(() => firebaseFirestoreDb);
}

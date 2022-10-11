import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/data/models/weight_model.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/data/repositories/weight_tracker_repository.dart';

part 'fetch_weights_event.dart';
part 'fetch_weights_state.dart';

class FetchWeightsBloc extends Bloc<FetchWeightsEvent, FetchWeightsState> {
  final WeightTrackerRepository weightTrackerRepository;
  late final StreamSubscription<QuerySnapshot> _weightListSubscription;
  FetchWeightsBloc({required this.weightTrackerRepository})
      : super(FetchWeightsInitial()) {
    _weightListSubscription = weightTrackerRepository
        .fetchWeightsasStream()
        .listen((weight) => add(GetFetchWeightsEvent()));
    on<FetchWeightsEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is GetFetchWeightsEvent) {
        emit(FetchWeightTrackerLoading());
        try {
          final result = await weightTrackerRepository.fetchWeights();
          emit(FetchWeightTrackerLoaded(weights: result));
        } catch (e) {
          emit(FetchWeightTrackerError(message: e.toString()));
        }
      }
    });
  }
  @override
  Future<void> close() {
    _weightListSubscription.cancel();
    return super.close();
  }
}

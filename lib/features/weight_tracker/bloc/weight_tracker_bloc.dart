import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/data/models/weight_model.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/data/repositories/weight_tracker_repository.dart';

part 'weight_tracker_event.dart';
part 'weight_tracker_state.dart';

class WeightTrackerBloc extends Bloc<WeightTrackerEvent, WeightTrackerState> {
  final WeightTrackerRepository weightTrackerRepository;

  WeightTrackerBloc({required this.weightTrackerRepository})
      : super(WeightTrackerInitial()) {
    on<WeightTrackerEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is AddWeightEvent) {
        emit(WeightTrackerLoading());
        try {
          final result = await weightTrackerRepository.addWeight(event.weight);
          emit(WeightTrackerLoaded());
        } catch (e) {
          emit(WeightTrackerError(message: e.toString()));
        }
      } else if (event is UpdateWeightEvent) {
        emit(WeightTrackerLoading());
        try {
          final result = await weightTrackerRepository.updateWeight(
              event.weight, event.id);
          emit(WeightTrackerLoaded());
        } catch (e) {
          emit(WeightTrackerError(message: e.toString()));
        }
      } else if (event is DeleteWeightByIdEvent) {
        emit(WeightTrackerLoading());
        try {
          final result = await weightTrackerRepository.removeWeight(event.id);
          emit(WeightTrackerLoaded());
        } catch (e) {
          emit(WeightTrackerError(message: e.toString()));
        }
      } else if (event is FetchWeightByIdEvent) {
        emit(WeightTrackerLoading());
        try {
          final result = await weightTrackerRepository.getWeightById(event.id);
          emit(WeightTrackerLoaded());
        } catch (e) {
          emit(WeightTrackerError(message: e.toString()));
        }
      }
    });
  }
}

part of 'weight_tracker_bloc.dart';

abstract class WeightTrackerState extends Equatable {
  const WeightTrackerState();

  @override
  List<Object> get props => [];
}

class WeightTrackerInitial extends WeightTrackerState {}

class WeightTrackerLoading extends WeightTrackerState {}

class WeightTrackerLoaded extends WeightTrackerState {}

class WeightTrackerError extends WeightTrackerState {
  final String message;

  const WeightTrackerError({required this.message});
}

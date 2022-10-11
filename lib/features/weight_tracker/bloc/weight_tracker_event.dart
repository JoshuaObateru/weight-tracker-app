part of 'weight_tracker_bloc.dart';

abstract class WeightTrackerEvent extends Equatable {
  const WeightTrackerEvent();

  @override
  List<Object> get props => [];
}

class AddWeightEvent extends WeightTrackerEvent {
  final WeightModel weight;

  const AddWeightEvent({required this.weight});
}

class UpdateWeightEvent extends WeightTrackerEvent {
  final WeightModel weight;
  final String id;

  const UpdateWeightEvent({required this.weight, required this.id});
}

class FetchWeightByIdEvent extends WeightTrackerEvent {
  final String id;

  const FetchWeightByIdEvent({required this.id});
}

class DeleteWeightByIdEvent extends WeightTrackerEvent {
  final String id;

  const DeleteWeightByIdEvent({required this.id});
}

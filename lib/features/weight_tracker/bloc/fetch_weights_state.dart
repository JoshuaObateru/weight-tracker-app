part of 'fetch_weights_bloc.dart';

abstract class FetchWeightsState extends Equatable {
  const FetchWeightsState();

  @override
  List<Object> get props => [];
}

class FetchWeightsInitial extends FetchWeightsState {}

class FetchWeightTrackerLoading extends FetchWeightsState {}

class FetchWeightTrackerLoaded extends FetchWeightsState {
  final List<WeightModel> weights;

  const FetchWeightTrackerLoaded({required this.weights});
}

class FetchWeightTrackerError extends FetchWeightsState {
  final String message;

  const FetchWeightTrackerError({required this.message});
}

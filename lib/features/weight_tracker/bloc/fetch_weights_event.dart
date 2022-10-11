part of 'fetch_weights_bloc.dart';

abstract class FetchWeightsEvent extends Equatable {
  const FetchWeightsEvent();

  @override
  List<Object> get props => [];
}

class GetFetchWeightsEvent extends FetchWeightsEvent {}

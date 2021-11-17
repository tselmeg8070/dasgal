part of 'weight_cubit.dart';

@immutable
abstract class WeightState {}

class WeightInitial extends WeightState {
}

class GotWeights extends WeightState {
  final List<WeightModel> models;
  GotWeights({required this.models});
}

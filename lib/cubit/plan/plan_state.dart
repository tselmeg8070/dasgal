part of 'plan_cubit.dart';

@immutable
abstract class PlanState {}

class PlanInitial extends PlanState {}


class GotPlan extends PlanState {
  final int day;
  final List<PlanModel> models;
  GotPlan({required this.models, required this.day});
}
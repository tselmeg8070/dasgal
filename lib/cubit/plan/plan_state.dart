part of 'plan_cubit.dart';

@immutable
abstract class PlanState {}

class PlanInitial extends PlanState {}


class GotPlan extends PlanState {
  final int day;
  final List<PlanModel> models;
  final List<HistoryModel> history;
  GotPlan({required this.models, required this.history, required this.day});
}
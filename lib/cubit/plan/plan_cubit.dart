import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dasgal/models/history_model.dart';
import 'package:dasgal/models/muscle_model.dart';
import 'package:dasgal/models/plan_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'plan_state.dart';

class PlanCubit extends Cubit<PlanState> {
  PlanCubit() : super(PlanInitial());

  DateTime createdAt = DateTime.now();
  DocumentSnapshot? userSnap;

  String getName() {
    if(state is GotPlan) {
      return userSnap!["name"];
    }
    return "";
  }

  Future<void> getModels() async {
    if(state is PlanInitial) {
      List<PlanModel> models = [];
      List<HistoryModel> history = [];
      try {
        CollectionReference users = FirebaseFirestore.instance.collection('users');
        User? currentUser = FirebaseAuth.instance.currentUser;
        userSnap = await users.doc(currentUser!.uid).get();
        createdAt = DateTime.fromMillisecondsSinceEpoch(userSnap!["createdAt"]);
        CollectionReference collection = FirebaseFirestore.instance.collection('plans');
        DocumentSnapshot documentSnapshot = await collection.doc("zaKKIo13bf4LPJLh4Htx").get();
        for(int i = 0; i < documentSnapshot["plan"].length; i++) {
          models.add(PlanModel.fromJson(documentSnapshot["plan"][i]));
        }
        for(int i = 0; i < userSnap!["history"].length; i++) {
          history.add(HistoryModel.fromJson(userSnap!["history"][i]));
        }
        emit(GotPlan(models: models, history: history, day: 0));
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void changeDay(int day) {
    if(state is GotPlan) {
      List<PlanModel> models = (state as GotPlan).models;
      List<HistoryModel> history = (state as GotPlan).history;
      emit(GotPlan(models: models, history: history, day: day));
    }
  }

  List<PlanModel> getPlan() {
    List<PlanModel> plans = [];
    if(state is GotPlan) {
      DateTime date = DateTime.now();
      if((state as GotPlan).day > 0) {
        date = date.add(Duration(days: (state as GotPlan).day));
      } else {
        date = date.subtract(Duration(days: (state as GotPlan).day));
      }
      List<PlanModel> models = (state as GotPlan).models;
      int diff = date.difference(createdAt).inDays;
      plans.add(models[diff % models.length]);
    }
    return plans;
  }


  Future<void> endWorkout(MuscleModel muscleModel) async {
    try {
      if(userSnap != null && state is GotPlan) {
        int days = userSnap!["days"];
        DateTime endDate = DateTime.now().subtract(const Duration(days: 3));
        List<HistoryModel> history = (state as GotPlan).history;
        history = history.where((element) =>
          element.createdAt.millisecondsSinceEpoch > endDate.millisecondsSinceEpoch).toList();
        history.add(HistoryModel.fromJson({
          "createdAt": DateTime.now().millisecondsSinceEpoch, "muscleMap": muscleModel.toJson()
        }));
        try {
          DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
          history.firstWhere((element) => element.createdAt.day == yesterday.day);
          days++;
        } catch(e) {
          days = 1;
        }
        await userSnap!.reference.update({
          "history": history.map<Map>((e) => e.toJson()).toList(),
          "days": days
        });
        emit(GotPlan(models: (state as GotPlan).models,
            history: history, day: (state as GotPlan).day));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  bool checkDay(int i) {
    if(state is GotPlan) {
      DateTime checker = DateTime.now().subtract(Duration(days: i));
      try {
        (state as GotPlan).history.firstWhere((element) => element.createdAt.day == checker.day);
        return true;
      } catch(e) {
        return false;
      }
    }
    return false;
  }


  MuscleModel getMuscleModel() {
    MuscleModel model = MuscleModel(
      chest: 0,
      deltoid: 0,
      bicep: 0,
      abs: 0,
      obliques: 0,
      quadriceps: 0,
      hamstring: 0,
      calves: 0,
      butt: 0,
      lats: 0,
      trapezius: 0,
      infraspinatus: 0,
      forearms: 0,
      neck: 0,
      triceps: 0,
    );
    if(state is GotPlan) {
      DateTime endDate = DateTime.now().subtract(const Duration(days: 3));
      List<HistoryModel> history = (state as GotPlan).history;
      history = history.where((element) =>
      element.createdAt.millisecondsSinceEpoch > endDate.millisecondsSinceEpoch).toList();
      for (var element in history) {
        model.chest = max(element.muscleModel.chest, model.chest);
        model.deltoid = max(element.muscleModel.deltoid, model.deltoid);
        model.bicep = max(element.muscleModel.bicep, model.bicep);
        model.abs = max(element.muscleModel.abs, model.abs);
        model.obliques = max(element.muscleModel.obliques, model.obliques);
        model.quadriceps = max(element.muscleModel.quadriceps, model.quadriceps);
        model.hamstring = max(element.muscleModel.hamstring, model.hamstring);
        model.calves = max(element.muscleModel.calves, model.calves);
        model.butt = max(element.muscleModel.butt, model.butt);
        model.lats = max(element.muscleModel.lats, model.lats);
        model.trapezius = max(element.muscleModel.trapezius, model.trapezius);
        model.infraspinatus = max(element.muscleModel.infraspinatus, model.infraspinatus);
        model.forearms = max(element.muscleModel.forearms, model.forearms);
        model.neck = max(element.muscleModel.neck, model.neck);
        model.triceps = max(element.muscleModel.triceps, model.triceps);
      }
    }
    return model;
  }

  int getDay() {
    int days = 0;
    if(state is GotPlan) {
      List<HistoryModel> history = (state as GotPlan).history;
      try {
        DateTime endDate = DateTime.now().subtract(const Duration(days: 2));
        history.firstWhere((element) => element.createdAt.millisecondsSinceEpoch >= endDate.millisecondsSinceEpoch);
        days = userSnap!["days"];
      } catch(e) {
        days = 0;
      }
    }
    return days;
  }
}

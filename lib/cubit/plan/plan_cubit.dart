import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dasgal/models/plan_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'plan_state.dart';

class PlanCubit extends Cubit<PlanState> {
  PlanCubit() : super(PlanInitial());

  DateTime createdAt = DateTime.now();

  Future<void> getModels() async {
    if(state is PlanInitial) {
      List<PlanModel> models = [];
      try {
        CollectionReference users = FirebaseFirestore.instance.collection('users');
        User? currentUser = FirebaseAuth.instance.currentUser;
        DocumentSnapshot userSnap = await users.doc(currentUser!.uid).get();
        createdAt = DateTime.fromMillisecondsSinceEpoch(userSnap["createdAt"]);
        CollectionReference collection = FirebaseFirestore.instance.collection('plans');
        DocumentSnapshot documentSnapshot = await collection.doc(userSnap["gender"] == 1 ? "zaKKIo13bf4LPJLh4Htx" : "").get();
        for(int i = 0; i < documentSnapshot["plan"].length; i++) {
          models.add(PlanModel.fromJson(documentSnapshot["plan"][i]));
        }
        emit(GotPlan(models: models, day: 0));
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void changeDay(int day) {
    if(state is GotPlan) {
      List<PlanModel> models = (state as GotPlan).models;
      emit(GotPlan(models: models, day: day));
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
}

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dasgal/models/weight_model.dart';
import 'package:dasgal/presentation/screens/main/analytic/graphic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'weight_state.dart';

class WeightCubit extends Cubit<WeightState> {
  WeightCubit() : super(WeightInitial());

  double maxY = 0.0;
  double minY = 200.0;
  int height = 0;
  int age = 0;
  int gender = 0;


  Future<void> getWeights() async {
    if(state is! GotWeights) {
      List<WeightModel> models = [];
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      User? currentUser = FirebaseAuth.instance.currentUser;
      DocumentSnapshot documentSnapshot = await users.doc(currentUser!.uid).get();
      height = documentSnapshot["height"];
      age = documentSnapshot["bornYear"] - DateTime.now().year;
      gender = documentSnapshot["gender"];
      for(int i = 0; i < documentSnapshot["weights"].length; i++) {
        models.add(WeightModel.fromJson(documentSnapshot["weights"][i]));
      }
      emit(GotWeights(models: models));
    }
  }

  List<List<DataModel>> getChartData() {
    List<List<DataModel>> models = [[]];
    if(state is GotWeights) {
      for(int i = 0; i < (state as GotWeights).models.length; i++) {
        WeightModel model = (state as GotWeights).models[i];
        maxY = max(model.weight, maxY);
        minY = min(model.weight, minY);
        models[0].add(DataModel(y: model.weight,
            x: (state as GotWeights).models.first.createdAt.difference(model.createdAt).inDays.abs().toDouble(),
            text: ''));
      }
    }
    return models;
  }

  Future<bool> addWeight(double weight) async {
    if (state is GotWeights) {
      List<WeightModel> models = (state as GotWeights).models;
      List<Map> maps = [];
      DateTime date = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 4);
      if(models.last.createdAt == date) {
        models[models.length - 1].weight = weight;
      } else {
        models.add(WeightModel.fromJson({
          "weight": weight,
          "createdAt": date
              .millisecondsSinceEpoch
        }));
      }
      for (int i = 0; i < models.length; i++) {
        maps.add(models[i].toJson());
      }
      try {
        CollectionReference users = FirebaseFirestore.instance.collection('users');
        User? currentUser = FirebaseAuth.instance.currentUser;
        await users.doc(currentUser!.uid).update({
          "weight": weight,
          "weights": maps,
        });
        emit(GotWeights(models: models));
        return true;
      } catch (e) {
        print(e.toString());
      }
    }
    return false;
  }

  double getCurrentWeight() {
    if(state is GotWeights) {
      return (state as GotWeights).models.last.weight;
    }
    return 0.0;
  }

  double getDiffWeight() {
    if(state is GotWeights) {
      return (state as GotWeights).models.last.weight - (state as GotWeights).models.first.weight;
    }
    return 0.0;
  }

  double getMax() {
    return maxY + 6;
  }

  double getMin() {
    return minY - 6;
  }

  List<double> calculateCalorie() {
    List<double> results = [0.0, 0.0, 0.0, 0.0];
    if(state is GotWeights) {
      double weight = (state as GotWeights).models.last.weight;
      double bmr = 0;
      if(gender == 2) {
        bmr = 13.397 * weight + 4.799 * height - 5.677 * age + 88.362;
      } else {
        bmr = 9.247 * weight + 3.098 * height - 4.330 * age + 447.593;
      }
      bmr = bmr * 1.375;
      double protein = bmr * 0.4 / 4;
      double carbohydrate = bmr * 0.3 / 4;
      double fat = bmr * 0.3 / 9;
      results[0] = bmr;
      results[1] = protein;
      results[2] = carbohydrate;
      results[3] = fat;
    }
    return results;
  }
}

import 'package:dasgal/models/muscle_model.dart';

class HistoryModel {
  MuscleModel muscleModel;
  DateTime createdAt;

  HistoryModel.fromJson(Map json)
      : muscleModel = MuscleModel.fromJson(json["muscleMap"]),
        createdAt = DateTime.fromMillisecondsSinceEpoch(json["createdAt"]);

  Map toJson() {
    return ({
      "muscleMap": muscleModel.toJson(),
      "createdAt": createdAt.millisecondsSinceEpoch
    });
  }
}
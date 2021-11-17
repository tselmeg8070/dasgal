class WeightModel {
  double weight;
  DateTime createdAt;

  WeightModel.fromJson(Map json)
      : weight = (json["weight"] ?? 0.0) * 1.0,
        createdAt = DateTime.fromMillisecondsSinceEpoch(json["createdAt"] ?? 0);

  Map toJson() {
    return ({
      "weight": weight,
      "createdAt": createdAt.millisecondsSinceEpoch
    });
  }
}
class UserModel {
  String uid;
  String name;
  int gender;
  int bornYear;
  int height;
  double weight;
  List<UserPlanModel> plans;
  DateTime createdAt;

  UserModel.fromJson(Map json)
      : uid = json["uid"] ?? "",
        name = json["name"] ?? "",
        gender = json["gender"] ?? 0,
        bornYear = json["bornYear"] ?? 0,
        height = json["height"] ?? 0,
        weight = json["weight"] ?? 0.0,
        plans = (json["plans"] ?? []).map<UserPlanModel>((e) => UserPlanModel.fromJson(e)).toList(),
        createdAt = DateTime.fromMillisecondsSinceEpoch(json["createdAt"] ?? 0);
}

class UserPlanModel {
  String uid;
  DateTime createdAt;

  UserPlanModel.fromJson(Map json)
    : uid = json["uid"],
      createdAt = DateTime.fromMillisecondsSinceEpoch(json["createdAt"]);
}
import 'package:dasgal/models/plan_model.dart';

class PlanWithPaymentModel {
  int days;
  String image;
  String name;
  String uid;
  String video;
  int price;
  List<PlanModel> plans;

  PlanWithPaymentModel.fromJson(Map json)
      : days = json["days"],
        image = json["image"],
        name = json["name"],
        uid = json["uid"],
        video = json["video"],
        price = json["price"],
        plans = List<PlanModel>.from(json["plan"].map((i) => PlanModel.fromJson(i)).toList());

}
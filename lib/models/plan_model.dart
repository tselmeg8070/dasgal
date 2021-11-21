class PlanModel {
  Duration duration;
  String image;
  String title;
  String subTitle;
  List<RoundModel> rounds;

  PlanModel.fromJson(Map json)
      : duration = Duration( seconds: json["duration"] ?? 0.0),
        title = json["title"],
        subTitle = json["subTitle"],
        rounds = List<RoundModel>.from(json["rounds"].map((i) => RoundModel.fromJson(i)).toList()),
        image = json["image"];

  Map toJson() {
    return ({
      "image": image,
      "title": title,
      "subTitle": subTitle,
      "duration": duration.inSeconds
    });
  }
}


class RoundModel {
  int count;
  String title;
  List<WorkoutModel> workouts;

  RoundModel.fromJson(Map json)
      : title = json["title"],
        workouts = List<WorkoutModel>.from(json["workouts"].map((i) => WorkoutModel.fromJson(i)).toList()),
        count = json["count"];

  Map toJson() {
    return ({
      "title": title,
      "count": count,
    });
  }
}


class WorkoutModel {
  Duration duration;
  String name;
  String video;
  String image;

  WorkoutModel.fromJson(Map json)
      : name = json["name"],
        video = json["video"],
        duration = Duration(seconds: json["duration"]),
        image = json["image"];

  Map toJson() {
    return ({
      "name": name,
      "image": image,
      "video": video,
      "duration": duration.inSeconds,
    });
  }
}
class MuscleModel {
  int chest;
  int deltoid;
  int bicep;
  int abs;
  int obliques;
  int quadriceps;
  int hamstring;
  int calves;
  int butt;
  int lats;
  int triceps;
  int trapezius;
  int infraspinatus;
  int forearms;
  int neck;

  MuscleModel({
    required this.chest,
    required this.deltoid,
    required this.bicep,
    required this.abs,
    required this.obliques,
    required this.quadriceps,
    required this.hamstring,
    required this.calves,
    required this.butt,
    required this.lats,
    required this.trapezius,
    required this.infraspinatus,
    required this.forearms,
    required this.neck,
    required this.triceps,
  });

  MuscleModel.fromJson(Map json)
      : chest = json["chest"] ?? 0,
        deltoid = json["deltoid"] ?? 0,
        bicep = json["bicep"] ?? 0,
        abs = json["abs"] ?? 0,
        obliques = json["obliques"] ?? 0,
        quadriceps = json["quadriceps"] ?? 0,
        hamstring = json["hamstring"] ?? 0,
        calves = json["calves"] ?? 0,
        butt = json["butt"] ?? 0,
        lats = json["lats"] ?? 0,
        trapezius = json["trapezius"] ?? 0,
        infraspinatus = json["infraspinatus"] ?? 0,
        forearms = json["forearms"] ?? 0,
        neck = json["neck"] ?? 0,
        triceps = json["triceps"] ?? 0;

  Map toJson() {
    return ({
      "chest": chest,
      "deltoid": deltoid,
      "bicep": bicep,
      "abs": abs,
      "obliques": obliques,
      "quadriceps": quadriceps,
      "hamstring": hamstring,
      "calves": calves,
      "butt": butt,
      "lats": lats,
      "trapezius": trapezius,
      "infraspinatus": infraspinatus,
      "forearms": forearms,
      "neck": neck,
      "triceps": triceps,
    });
  }
}
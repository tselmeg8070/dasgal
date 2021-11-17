import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  String name = "";
  int gender = 0;
  int bornYear = 0;
  int height = 0;
  double weight = 0.0;

  void register(String mName, int mGender, int mAge, int mHeight, int mWeight, int mWeightSub) async {
    emit(RegistrationLoading());
    name = mName;
    gender = mGender;
    bornYear = DateTime.now().year - mAge;
    height = mHeight;
    weight = mWeight + 0.1 * mWeightSub;
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      DocumentReference doc = users.doc(currentUser!.uid);
      await doc.set({
        "phone": currentUser.phoneNumber,
        "name": name,
        "gender": gender,
        "bornYear": bornYear,
        "height": height,
        "weight": weight,
        "weights": [
          {
            "weight": weight,
            "createdAt": DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 4).millisecondsSinceEpoch
          }
        ],
        "createdAt": DateTime.now().millisecondsSinceEpoch
      });
      await doc.update({"uid": doc.id});
      emit(RegistrationSuccess());
    } catch (e) {
      emit(RegistrationFailed());
    }

  }

}

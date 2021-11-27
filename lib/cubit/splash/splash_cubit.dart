import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> checkAuthentication() async {
    Future.delayed(const Duration(seconds: 2), () async {
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      User? currentUser = FirebaseAuth.instance.currentUser;
      if(currentUser == null) {
        print("UnAuthenticated");
        emit(UnAuthenticated());
      } else {
        DocumentSnapshot doc = await users.doc(currentUser.uid).get();
        if(doc.exists) {
          print("Authenticated");
          emit(Authenticated());
        } else {
          print("Register");
          emit(Register());
        }
      }
    });

  }
}

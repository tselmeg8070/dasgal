import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(RegistrationInitial(phone: ""));

  String verificationId = "";

  String phoneNumber = "";

  void setPhone(String phone) {
    phoneNumber = phone;
    emit(RegistrationInitial(phone: phone));
  }

  bool validatePhoneNumber() {
    if(phoneNumber.length == 8) {
      for(int i = 0; i < phoneNumber.length; i++) {
        if(phoneNumber.codeUnitAt(i) < '0'.codeUnitAt(0) || phoneNumber.codeUnitAt(i) > '9'.codeUnitAt(0)) {
          return false;
        }
      }
      return true;
    }
    return false;
  }


  Future<bool> checkPhoneNumber(String phone) async {
    emit(RegistrationLoading(phone: phone));
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    QuerySnapshot<Object?> doc = await users.where("phone", isEqualTo: "+976" + phone).get();
    emit(RegistrationInitial(phone: phone));
    if(doc.size == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> sendOTP() async {
    emit(RegistrationLoading(phone: phoneNumber));
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+976" + phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        print("Verified");
        emit(SentOTP(phone: phoneNumber));
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Failed");
        print(e.toString());
        emit(RegistrationFailed(phone:
        phoneNumber, response: e.code));
      },
      codeSent: (String mVerificationId, int? resendToken) {
        print("CodeSent");
        verificationId = mVerificationId;
        emit(SentOTP(phone: phoneNumber));
      },
      codeAutoRetrievalTimeout: (String mVerificationId) {
        print("Timeout");
        verificationId = mVerificationId;
        // emit(RegistrationFailed(phone:
        // phoneNumber, response: "Timeout"));
      },
    );
  }

  Future<void> verifyOTP(String smsCode) async {
    emit(OTPLoading(phone: phoneNumber));
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(OTPVerified(phone: phoneNumber));
    } catch (e) {
      emit(OTPFailed(phone: phoneNumber, response: "Амжилтгүй"));
    }
  }
}

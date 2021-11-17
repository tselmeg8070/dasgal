part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class RegistrationInitial extends AuthenticationState {
  final String phone;
  RegistrationInitial({required this.phone});
}

class RegistrationLoading extends AuthenticationState {
  final String phone;
  RegistrationLoading({required this.phone});
}

class SentOTP extends AuthenticationState {
  final String phone;
  SentOTP({required this.phone});
}

class OTPVerified extends AuthenticationState {
  final String phone;
  OTPVerified({required this.phone});
}

class OTPFailed extends AuthenticationState {
  final String phone;
  final String response;
  OTPFailed({required this.phone, required this.response});
}


class OTPLoading extends AuthenticationState {
  final String phone;
  OTPLoading({required this.phone});
}

class RegistrationFailed extends AuthenticationState {
  final String phone;
  final String response;
  RegistrationFailed({required this.phone, required this.response});
}
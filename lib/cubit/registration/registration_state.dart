part of 'registration_cubit.dart';

@immutable
abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}
class RegistrationLoading extends RegistrationState {}
class RegistrationSuccess extends RegistrationState {}
class RegistrationFailed extends RegistrationState {}

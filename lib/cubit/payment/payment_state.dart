part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}
class PaymentError extends PaymentState {}
class GotPayment extends PaymentState {
  final PaymentModel paymentModel;
  GotPayment({required this.paymentModel});
}

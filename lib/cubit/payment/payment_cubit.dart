import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_functions/cloud_functions.dart';
part 'payment_state.dart';

HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('listFruit');

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  Future<void> createInvoice(String uid) async {
    final resp = await callable.call(<String, dynamic>{
      'uid': 'A message sent from a client device',
      'plan_uid': 'uid',
    });
  }
}

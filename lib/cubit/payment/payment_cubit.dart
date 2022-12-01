import 'package:bloc/bloc.dart';
import 'package:dasgal/models/qpay_model.dart';
import 'package:meta/meta.dart';
import 'package:cloud_functions/cloud_functions.dart';
part 'payment_state.dart';

HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('requestPayment');

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  Future<void> createInvoice(String uid) async {
    final resp = await callable.call(<String, dynamic>{
      'uid': uid,
    });
    if(resp.data["status"] == "success") {
      PaymentModel model = PaymentModel.fromJson(resp.data["data"]);
      emit(GotPayment(paymentModel: model));
    } else {
      print(resp.data);
      emit(PaymentError());
    }
  }
}

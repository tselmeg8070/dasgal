import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/sizes.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:dasgal/cubit/payment/payment_cubit.dart';
import 'package:dasgal/models/plan_with_payment_model.dart';
import 'package:dasgal/models/qpay_model.dart';
import 'package:dasgal/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentScreen extends StatelessWidget {
  final PlanWithPaymentModel planModel;
  const PaymentScreen({Key? key, required this.planModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,##,000');
    BlocProvider.of<PaymentCubit>(context).createInvoice(planModel.uid);

    Widget _buildBank(PaymentLinkModel model) {
      return GestureDetector(
        onTap: () async {
          if(await canLaunch(model.link)) {
            launch(model.link);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: AppColors.textColor, width: 1)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                  color: AppColors.surfaceSoft
                ),
                child: Image.network(model.logo, height: 36, width: 36,)
              ),
              SizedBox(width: 16,),
              Expanded(child: Text(model.description, maxLines: 1, style: AppStyle.textBody2,))
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: "Хөтөлбөрт хамрагдах",
      ),
      body: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if(state is PaymentInitial) {
            return const SizedBox();
          }
          if(state is PaymentError) {
            return const Text("Error");
          }
          List<PaymentLinkModel> links = (state as GotPayment).paymentModel.urls;
          return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width,),
                    const SizedBox(height: 16,),
                    const Text("Нийт дүн", style: AppStyle.textSubtitle1,),
                    const SizedBox(height: 8,),
                    Text(formatter.format(planModel.price) + "₮ ", style: AppStyle.textHeader4,),
                    const SizedBox(height: 38,),
                    Column(
                      children: links.map<Widget>((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildBank(e),
                      )).toList()
                    ),
                    const SizedBox(height: 38,),
                  ],
                ),
              ),
            );
  },
),
    );
  }
}

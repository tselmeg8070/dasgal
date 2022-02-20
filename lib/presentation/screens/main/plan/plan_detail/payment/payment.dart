import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/sizes.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:dasgal/models/plan_with_payment_model.dart';
import 'package:dasgal/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends StatelessWidget {
  final PlanWithPaymentModel planModel;
  const PaymentScreen({Key? key, required this.planModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,##,000');

    Widget _buildBank(String image, String name) {
      return Container(
        padding: EdgeInsets.all(8),
        width: 96,
        height: 96,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: AppColors.textColor, width: 1)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(1000)),
                color: AppColors.surfaceSoft
              ),
              child: Image.asset("assets/images/banks/" + image, height: 36, width: 36,)
            ),
            Text(name, style: AppStyle.textCaption,)
          ],
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: "Үйлчилгээний нөхцөл",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width,),
              SizedBox(height: 16,),
              Text("Нийт дүн", style: AppStyle.textSubtitle1,),
              SizedBox(height: 8,),
              Text(formatter.format(planModel.price) + "₮ ", style: AppStyle.textHeader4,),
              SizedBox(height: 38,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBank("arig.png", "Ариг банк"),
                  _buildBank("arig.png", "Ариг банк"),
                  _buildBank("arig.png", "Ариг банк"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

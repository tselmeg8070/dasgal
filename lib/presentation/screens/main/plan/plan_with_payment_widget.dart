import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:dasgal/models/plan_model.dart';
import 'package:dasgal/models/plan_with_payment_model.dart';
import 'package:dasgal/presentation/screens/main/plan/plan_detail/plan_detail.dart';
import 'package:dasgal/presentation/screens/main/plan/workout_detail/workout_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';


class PlanWithPaymentWidget extends StatelessWidget {

  final PlanWithPaymentModel model;
  final bool isDone;
  const PlanWithPaymentWidget({Key? key, required this.model,
    this.isDone = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlanDetailScreen(model: model)));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: Image.network(
                    model.image, fit: BoxFit.cover,),
                ),
              ),
              const SizedBox(width: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.name, style: AppStyle.textSubtitle2.copyWith(fontWeight: FontWeight.bold),),
                  const SizedBox(height: 4,),
                  Text("${model.days} өдөр", style: AppStyle.textCaption.copyWith(color: AppColors.textColor))
                ],
              )
            ],
          ),

          Container(
            width: 35,
            height: 70,
            decoration: BoxDecoration(
                color: isDone ? const Color(0xFFDAFCE9) : AppColors.primaryLight3,
                borderRadius: const BorderRadius.all(Radius.circular(8))
            ),
            child: Icon(
              isDone ? FeatherIcons.check : FeatherIcons.chevronRight,
              color: isDone ? AppColors.feedbackSuccess : AppColors.primary,
              size: 18,
            ),
          )
        ],
      ),
    );
  }
}

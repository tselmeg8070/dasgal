import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:dasgal/models/plan_model.dart';
import 'package:dasgal/presentation/screens/main/plan/workout_detail/workout_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';


class PlanWidget extends StatelessWidget {

  final PlanModel model;
  const PlanWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => WorkoutDetailScreen(model: model)));
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
              SizedBox(width: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.title, style: AppStyle.textSubtitle2.copyWith(fontWeight: FontWeight.bold),),
                  SizedBox(height: 4,),
                  Text("${model.subTitle} - ${model.duration.inMinutes} мин", style: AppStyle.textCaption.copyWith(color: AppColors.textColor))
                ],
              )
            ],
          ),

          Container(
            width: 35,
            height: 70,
            decoration: BoxDecoration(
                color: AppColors.primaryLight3,
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Icon(FeatherIcons.chevronRight, color: AppColors.primary,),
          )
        ],
      ),
    );
  }
}

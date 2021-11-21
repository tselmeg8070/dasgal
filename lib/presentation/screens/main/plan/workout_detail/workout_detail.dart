import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/sizes.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:dasgal/models/plan_model.dart';
import 'package:dasgal/presentation/screens/main/plan/workout_detail/workout/workout.dart';
import 'package:dasgal/presentation/widgets/custom_app_bar.dart';
import 'package:dasgal/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class WorkoutDetailScreen extends StatelessWidget {

  final PlanModel model;
  const WorkoutDetailScreen({Key? key, required this.model}) : super(key: key);

  Widget _buildWorkoutWidget(WorkoutModel workout) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: const BoxDecoration(
            color: Color(0xFFF3EEFC),
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        width: double.maxFinite,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: Image.network(workout.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${workout.duration.inSeconds} сек", style: AppStyle.textCaption.copyWith(color: AppColors.textColor),),
                  Text(workout.name, style: AppStyle.textSubtitle2.copyWith(
                      fontWeight: FontWeight.normal,
                      color: AppColors.textColorHigh),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSizes.containerMargin, right: AppSizes.containerMargin, top: 8, bottom: 32),
      child: Container(
        height: 48,
        child: CustomButton(
          leadingIcon: false,
          text: "Эхлэх",
          iconColor: Colors.white,
          action: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WorkoutScreen(
                      planModel: model,
                    )));
          },
          color: AppColors.primary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNav(context),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8,),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(model.title,
                            style: AppStyle.textHeader6.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8,),
                          Text("${model.subTitle} - ${model.duration.inMinutes} мин",
                            style: AppStyle.textCaption.copyWith(color: AppColors.textColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24,),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16))
                      ),
                      height: 120, width: 120,
                      child: Image.network(model.image, fit: BoxFit.contain,),
                    )
                  ],
                )),
            const SizedBox(height: 24,),
            Padding(
              padding: const EdgeInsets.only(left: 44, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: model.rounds.map<Widget>((e) =>
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8,),
                      Text("${model.rounds.indexOf(e) + 1}-р үе",
                        style: AppStyle.textSubtitle1.copyWith(fontWeight: FontWeight.bold, color: AppColors.textColor),),
                      const SizedBox(height: 18,),
                      Column(
                        children: e.workouts.map<Widget>((workout) =>
                            _buildWorkoutWidget(workout)
                        ).toList()
                      )
                    ],
                  )
                ).toList(),
              ),
            )

          ],
        ),
      ),
    );
  }
}

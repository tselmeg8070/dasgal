import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/sizes.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:dasgal/cubit/payment/payment_cubit.dart';
import 'package:dasgal/models/plan_model.dart';
import 'package:dasgal/models/plan_with_payment_model.dart';
import 'package:dasgal/presentation/screens/main/plan/plan_detail/payment/payment.dart';
import 'package:dasgal/presentation/screens/main/plan/plan_detail/plan_video.dart';
import 'package:dasgal/presentation/screens/main/plan/plan_with_payment_widget.dart';
import 'package:dasgal/presentation/screens/main/plan/workout_detail/workout/video_player/custom_orientation_player.dart';
import 'package:dasgal/presentation/screens/main/plan/workout_detail/workout/workout.dart';
import 'package:dasgal/presentation/widgets/custom_app_bar.dart';
import 'package:dasgal/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../plan_widget.dart';

class PlanDetailScreen extends StatelessWidget {

  final PlanWithPaymentModel model;
  const PlanDetailScreen({Key? key, required this.model}) : super(key: key);



  Widget _buildBottomNav(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSizes.containerMargin, right: AppSizes.containerMargin, top: 8, bottom: 32),
      child: Container(
        height: 48,
        child: CustomButton(
          leadingIcon: false,
          text: "Худалдаж авах (${model.price}₮)",
          iconColor: Colors.white,
          action: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                    create: (_) => PaymentCubit(),
                    child: PaymentScreen(
                      planModel: model,
                    ))));
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
        physics: const BouncingScrollPhysics(),
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
                          Text(model.name,
                            style: AppStyle.textHeader6.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8,),
                          Text("Цээж болон гар - ${model.days} өдөр",
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
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                          child: Image.network(model.image, fit: BoxFit.cover,)),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text("Живх, салфетка зэргийг давтамжтай худалдан авалт хийх боломжтой бөгөөд таны худалдан авалт бүрээс 15% хөнгөлөх юм.", style: AppStyle.textBody2,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 24, right: 24),
              child: PlanVideo(url: model.video),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                "Хөтөлбөр",
                style: AppStyle.textSubtitle1
                    .copyWith(fontWeight: FontWeight.bold),),
                  const SizedBox(height: 24,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: model.plans.map<Widget>((e) =>
                        PlanWidget(model: e,)
                    ).toList(),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

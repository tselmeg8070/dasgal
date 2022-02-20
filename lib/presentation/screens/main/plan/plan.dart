import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/sizes.dart';
import 'package:dasgal/core/constants/strings.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:dasgal/cubit/plan/plan_cubit.dart';
import 'package:dasgal/models/plan_model.dart';
import 'package:dasgal/models/plan_with_payment_model.dart';
import 'package:dasgal/presentation/screens/main/plan/plan_widget.dart';
import 'package:dasgal/presentation/screens/main/plan/plan_with_payment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PlanCubit>(context).getModels();

    Widget _buildDayWidget(int day, bool isChecked, bool isToday) {
      DateTime dateTime = DateTime.now();
      if (day > 0) {
        dateTime = dateTime.add(Duration(days: day));
      } else {
        dateTime = dateTime.subtract(Duration(days: day.abs()));
      }
      return InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        onTap: () {
          BlocProvider.of<PlanCubit>(context).changeDay(day);
        },
        child: Container(
          width: 56,
          height: 60,
          decoration: BoxDecoration(
              color: isToday ? AppColors.primary : AppColors.surfaceSoft,
              borderRadius: const BorderRadius.all(Radius.circular(14))),
          padding: const EdgeInsets.only(left: 9, right: 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    daysShort[dateTime.weekday - 1],
                    style: AppStyle.textCaption.copyWith(
                        color: isToday ? Colors.white : AppColors.textColor),
                  ),
                  if (isChecked)
                    const Icon(
                      FeatherIcons.check,
                      size: 12,
                      color: AppColors.feedbackSuccess,
                    )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                dateTime.day.toString(),
                style: AppStyle.textSubtitle1
                    .copyWith(color: isToday ? Colors.white : null),
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.containerMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Таны \nхөтөлбөрүүд 💪",
                    style: AppStyle.textHeader5
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 55,
                  width: 85,
                  child: Stack(
                    children: [
                      Positioned(
                          right: 39,
                          top: 0,
                          child: SizedBox(
                              height: 46,
                              child: BlocBuilder<PlanCubit, PlanState>(
                                builder: (context, state) {
                                  return Text(
                                    BlocProvider.of<PlanCubit>(context)
                                        .getDay()
                                        .toString(),
                                    textAlign: TextAlign.right,
                                    style: AppStyle.textHeader4
                                        .copyWith(fontWeight: FontWeight.bold),
                                  );
                                },
                              ))),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Text(
                            "хоног\nтасалдаагүй",
                            textAlign: TextAlign.right,
                            style: AppStyle.textCaption
                                .copyWith(color: AppColors.textColor),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 42,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.containerMargin),
            child: BlocBuilder<PlanCubit, PlanState>(
              builder: (context, state) {
                int day = 0;
                if (state is GotPlan) {
                  day = state.day;
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDayWidget(
                        -2,
                        BlocProvider.of<PlanCubit>(context).checkDay(2),
                        -2 == day),
                    _buildDayWidget(
                        -1,
                        BlocProvider.of<PlanCubit>(context).checkDay(1),
                        -1 == day),
                    _buildDayWidget(
                        0,
                        BlocProvider.of<PlanCubit>(context).checkDay(0),
                        0 == day),
                    _buildDayWidget(1, false, 1 == day),
                    _buildDayWidget(2, false, 2 == day),
                  ],
                );
              },
            ),
          ),
          const SizedBox(
            height: 33,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.containerMargin),
            child: Text(
              "Үндсэн хөтөлбөр",
              style:
                  AppStyle.textSubtitle1.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.containerMargin),
            child: BlocBuilder<PlanCubit, PlanState>(
              builder: (context, state) {
                List<PlanModel> models =
                    BlocProvider.of<PlanCubit>(context).getPlan();
                bool isDone = false;
                if (state is GotPlan) {
                  if (state.day < 1) {
                    isDone = BlocProvider.of<PlanCubit>(context)
                        .checkDay((-1) * state.day);
                  }
                }
                return Column(
                    children: models.map<Widget>((model) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: PlanWidget(
                      model: model,
                      isDone: isDone,
                    ),
                  );
                }).toList());
              },
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          BlocBuilder<PlanCubit, PlanState>(
            builder: (context, state) {
              if(state is PlanInitial) {
                return const SizedBox();
              }
              List<PlanWithPaymentModel> models = (state as GotPlan).plans;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.containerMargin),
                    child: Text(
                      "Төлбөртэй хөтөлбөр",
                      style: AppStyle.textSubtitle1
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.containerMargin),
                    child: BlocBuilder<PlanCubit, PlanState>(
                      builder: (context, state) {

                        return Column(
                            children: models.map<Widget>((model) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: PlanWithPaymentWidget(
                              model: model,
                              isDone: false,
                            ),
                          );
                        }).toList());
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

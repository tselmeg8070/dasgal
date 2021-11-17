import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/sizes.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:dasgal/core/utilities/utility.dart';
import 'package:dasgal/cubit/weight/weight_cubit.dart';
import 'package:dasgal/presentation/screens/main/analytic/graphic.dart';
import 'package:dasgal/presentation/screens/main/analytic/weight_dialog.dart';
import 'package:dasgal/presentation/widgets/custom_bottom_dialog.dart';
import 'package:dasgal/presentation/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'musclemap.dart';

class AnalyticScreen extends StatelessWidget {
  AnalyticScreen({Key? key}) : super(key: key);


  _showBottomCalendar(BuildContext context, double weight) {
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return WeightDialog(weight: weight,);
        });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = [
      Padding(
        padding: const EdgeInsets.only(top: 32, bottom: 21),
        child: Center(
          child: Text(
            "Анализ",
            style: AppStyle.textHeader5.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      const MuscleMap(),
      const SizedBox(
        height: 46,
      ),
      BlocBuilder<WeightCubit, WeightState>(
  builder: (context, state) {
    List<double> results = BlocProvider.of<WeightCubit>(context).calculateCalorie();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Хооллолт өдөрт авах",
              style: AppStyle.textSubtitle1.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "Harris-Benedict томьёо",
              style: AppStyle.textCaption.copyWith(color: AppColors.textColor),
            ),
            const SizedBox(
              height: 22,
            ),
            Row(
              children: [
                Expanded(
                  child: MacroWidget(
                      image: "calorie.png",
                      text: "Калори авах",
                      value: "${Utility.numberWithCommas(results[0].toStringAsFixed(0))} ккл"),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: MacroWidget(
                      image: "carbo.png", text: "Нүүр ус", value: "${results[1].toStringAsFixed(0)} гр"),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                Expanded(
                  child: MacroWidget(
                      image: "protein.png", text: "Уураг", value: "${results[2].toStringAsFixed(0)} гр"),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: MacroWidget(
                      image: "fat.png", text: "Өөх тос", value: "${Utility.numberWithCommas(results[3].toStringAsFixed(0))} гр"),
                ),
              ],
            ),
          ],
        ),
      );
  },
),
      const SizedBox(
        height: 64,
      ),
      Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
          child: BlocBuilder<WeightCubit, WeightState>(
            builder: (context, state) {
              double currentWeight = BlocProvider.of<WeightCubit>(context).getCurrentWeight();
              double diffWeight = BlocProvider.of<WeightCubit>(context).getDiffWeight();
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Жингийн анализ",
                              style: AppStyle.textSubtitle1
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Нэмэх зорилготой",
                              style: AppStyle.textCaption
                                  .copyWith(color: AppColors.textColor),
                            ),
                          ],
                        ),
                        InkWell(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(8)),
                          onTap: () {
                            _showBottomCalendar(context, currentWeight);
                          },
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                color: AppColors.secondaryLight3),
                            child: const Center(
                              child: Icon(
                                FeatherIcons.plus,
                                size: 18,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    CustomMountainTopGraph(
                      yTitle: 'Жин (кг)',
                      chartData:
                      BlocProvider.of<WeightCubit>(context).getChartData(),
                      xTitle: 'Өдөр',
                      yMax: BlocProvider.of<WeightCubit>(context).getMax(),
                      yMin: BlocProvider.of<WeightCubit>(context).getMin(),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${diffWeight.toStringAsFixed(1)} кг",
                              style: AppStyle.textHeader5
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Өөрчлөлт",
                              style: AppStyle.textCaption
                                  .copyWith(color: AppColors.textColor),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${currentWeight.toStringAsFixed(1)} кг",
                              style: AppStyle.textHeader5
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Одоо",
                              style: AppStyle.textCaption
                                  .copyWith(color: AppColors.textColor),
                            ),
                          ],
                        ),
                      ],
                    )
                  ]);
            },
          )),
      const SizedBox(
        height: 32,
      )
    ];
    BlocProvider.of<WeightCubit>(context).getWeights();
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _widgets.length,
      itemBuilder: (context, index) {
        return _widgets[index];
      },
    );
  }
}

class MacroWidget extends StatelessWidget {
  final String image;
  final String text;
  final String value;

  const MacroWidget(
      {Key? key, required this.image, required this.text, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: AppColors.secondaryLight3),
          child: Center(
            child: SizedBox(
              height: 32,
              width: 32,
              child: Image.asset(
                "assets/images/$image",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style:
                  AppStyle.textSubtitle1.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              text,
              style:
                  AppStyle.textCaptionBold.copyWith(color: AppColors.textColor),
            ),
          ],
        )
      ],
    );
  }
}

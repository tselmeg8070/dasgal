import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/sizes.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:dasgal/cubit/weight/weight_cubit.dart';
import 'package:dasgal/presentation/widgets/custom_bottom_dialog.dart';
import 'package:dasgal/presentation/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeightDialog extends StatefulWidget {
  final double weight;

  const WeightDialog({Key? key, required this.weight}) : super(key: key);

  @override
  _WeightDialogState createState() => _WeightDialogState();
}

class _WeightDialogState extends State<WeightDialog> {
  int weight = 67;
  int weightSub = 0;

  @override
  void initState() {
    weight = widget.weight ~/ 1;
    weightSub = widget.weight ~/ 0.1 % 10;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: "Таны жин",
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 160,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 160,
                    child: CupertinoPicker(
                      backgroundColor: Colors.white,
                      itemExtent: 42,
                      scrollController:
                          FixedExtentScrollController(initialItem: weight - 30),
                      children: List.generate(120, (index) {
                        return SizedBox(
                          height: 42,
                          child: Center(
                            child: Text(
                              (30 + index).toString() + " кг",
                              textAlign: TextAlign.right,
                              style: AppStyle.textSubtitle1,
                            ),
                          ),
                        );
                      }),
                      onSelectedItemChanged: (value) {
                        setState(() {
                          weight = 30 + value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 160,
                    child: CupertinoPicker(
                      backgroundColor: Colors.white,
                      itemExtent: 42,
                      scrollController:
                          FixedExtentScrollController(initialItem: weightSub),
                      children: List.generate(10, (index) {
                        return SizedBox(
                          height: 42,
                          child: Center(
                            child: Text(
                              (100 * index).toString().padLeft(3, "0") + " гр",
                              textAlign: TextAlign.left,
                              style: AppStyle.textSubtitle1,
                            ),
                          ),
                        );
                      }),
                      onSelectedItemChanged: (value) {
                        setState(() {
                          weightSub = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          CustomButton(
            leadingIcon: false,
            text: 'Оруулах',
            action: () async {
              double temp = weight + weightSub * 0.1;
              if(await BlocProvider.of<WeightCubit>(context).addWeight(temp)) {
                Navigator.of(context).pop();
              }
            },
            color: AppColors.primary,
          ),
          Container(
            height: 40,
          ),
        ],
      ),
    ));
  }
}

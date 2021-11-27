import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/models/muscle_model.dart';
import 'package:dasgal/models/muscle_model.dart';
import 'package:dasgal/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class MuscleMap extends StatefulWidget {
  final MuscleModel model;
  const MuscleMap({Key? key, required this.model}) : super(key: key);

  @override
  State<MuscleMap> createState() => _MuscleMapState();
}

class _MuscleMapState extends State<MuscleMap> {

   bool isMale = true;
   bool isFront = true;


  @override
  Widget build(BuildContext context) {


    List<Widget> manFront = [
      Positioned(
          top: 0,
          left: 58.34,
          child: SizedBox(
              width: 58.33,
              height: 36.47,
              child: Image.asset("assets/images/muscle/male/front/${widget.model.neck.toString()}/neck.png", fit: BoxFit.contain,))),
      Positioned(
          left: 29.17,
          top: 27.89,
          child: SizedBox(
              width: 116.66,
              height: 39.69,
              child: Image.asset("assets/images/muscle/male/front/${widget.model.deltoid.toString()}/deltoid.png", fit: BoxFit.contain,))),
      Positioned(
          left: 48.28,
          top: 30.04,
          child: SizedBox(
              width: 78.44,
              height: 42.91,
              child: Image.asset("assets/images/muscle/male/front/${widget.model.chest.toString()}/chest.png", fit: BoxFit.contain,))),
      Positioned(
          left: 34.19,
          top: 62.22,
          child: SizedBox(
              width: 106.61,
              height: 39.69,
              child: Image.asset("assets/images/muscle/male/front/${widget.model.triceps.toString()}/triceps.png", fit: BoxFit.contain,))),
      Positioned(
          left: 23.14,
          top: 47.2,
          child: SizedBox(
              width: 128.73,
              height: 54.71,
              child: Image.asset("assets/images/muscle/male/front/${widget.model.bicep.toString()}/bicep.png", fit: BoxFit.contain,))),
      Positioned(
          left: 49.28,
          top: 67.51,
          child: SizedBox(
              width: 76.43,
              height: 78.31,
              child: Image.asset("assets/images/muscle/male/front/${widget.model.obliques.toString()}/obliques.png", fit: BoxFit.contain,))),
      Positioned(
          left: 69.4,
          top: 72.95,
          child: SizedBox(
              width: 36.21,
              height: 100.84,
              child: Image.asset("assets/images/muscle/male/front/${widget.model.abs.toString()}/abs.png", fit: BoxFit.contain,))),
      Positioned(
          left: 0,
          top: 96.55,
          child: SizedBox(
              width: 175,
              height: 63.29,
              child: Image.asset("assets/images/muscle/male/front/${widget.model.forearms.toString()}/forearms.png", fit: BoxFit.contain,))),
      Positioned(
          left: 42.24,
          top: 141.6,
          child: SizedBox(
              width: 90.51,
              height: 112.64,
              child: Image.asset("assets/images/muscle/male/front/${widget.model.quadriceps.toString()}/quadriceps.png", fit: BoxFit.contain,))),
      Positioned(
          left: 29.17,
          top: 266.04,
          child: SizedBox(
              width: 116.66,
              height: 86.89,
              child: Image.asset("assets/images/muscle/male/front/${widget.model.calves.toString()}/calves.png", fit: BoxFit.contain,))),
    ];

    List<Widget> manBack = [
      Positioned(
          top: 0,
          left: 49.13,
          child: SizedBox(
              width: 76.73,
              height: 89.14,
              child: Image.asset(
                "assets/images/muscle/male/back/${widget.model.trapezius.toString()}/trapezius.png",
                fit: BoxFit.contain,
              ))),
      Positioned(
          top: 31.06,
          left: 29.92,
          child: SizedBox(
              width: 115.15,
              height: 35.47,
              child: Image.asset(
                "assets/images/muscle/male/back/${widget.model.deltoid.toString()}/deltoid.png",
                fit: BoxFit.contain,
              ))),
      Positioned(
          top: 38.38,
          left: 46.17,
          child: SizedBox(
              width: 82.67,
              height: 32.44,
              child: Image.asset(
                "assets/images/muscle/male/back/${widget.model.infraspinatus.toString()}/infraspinatus.png",
                fit: BoxFit.contain,
              ))),
      Positioned(
          top: 52.03,
          left: 23.29,
          child: SizedBox(
              width: 128.41,
              height: 71.23,
              child: Image.asset(
                "assets/images/muscle/male/back/${widget.model.triceps.toString()}/triceps.png",
                fit: BoxFit.contain,
              ))),
      Positioned(
          top: 69.52,
          left: 49.01,
          child: SizedBox(
              width: 76.98,
              height: 74.21,
              child: Image.asset(
                "assets/images/muscle/male/back/${widget.model.lats.toString()}/lats.png",
                fit: BoxFit.contain,
              ))),
      Positioned(
          top: 119,
          left: 50.31,
          child: SizedBox(
              width: 74.38,
              height: 53.31,
              child: Image.asset(
                "assets/images/muscle/male/back/${widget.model.obliques.toString()}/obliques.png",
                fit: BoxFit.contain,
              ))),
      Positioned(
          top: 102.79,
          left: 0,
          child: SizedBox(
              width: 175,
              height: 65.68,
              child: Image.asset(
                "assets/images/muscle/male/back/${widget.model.forearms.toString()}/forearms.png",
                fit: BoxFit.contain,
              ))),
      Positioned(
          top: 151.84,
          left: 50.43,
          child: SizedBox(
              width: 74.13,
              height: 54.59,
              child: Image.asset(
                "assets/images/muscle/male/back/${widget.model.butt.toString()}/butt.png",
                fit: BoxFit.contain,
              ))),
      Positioned(
          top: 182.12,
          left: 46.68,
          child: SizedBox(
              width: 81.64,
              height: 99.8,
              child: Image.asset(
                "assets/images/muscle/male/back/${widget.model.hamstring.toString()}/hamstring.png",
                fit: BoxFit.fitWidth,
              ))),
      Positioned(
          top: 270.83,
          left: 40.55,
          child: SizedBox(
              width: 93.9,
              height: 83.17,
              child: Image.asset(
                "assets/images/muscle/male/back/${widget.model.calves.toString()}/calves.png",
                fit: BoxFit.contain,
              ))),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              size: CustomButtonSize.small,
              action: () {
                setState(() {
                  isFront = true;
                });
              },
              color: isFront ? AppColors.secondaryLight3 : Colors.white,
              text: "Урд тал",
              frameColor: isFront ? AppColors.secondaryLight3 : Colors.white,
              textColor: AppColors.textColorHigh,
            ),
            const SizedBox(
              width: 24,
            ),
            CustomButton(
              size: CustomButtonSize.small,
              action: () {
                setState(() {
                  isFront = false;
                });
              },
              color: !isFront ? AppColors.secondaryLight3 : Colors.white,
              text: "Ард тал",
              frameColor: !isFront ? AppColors.secondaryLight3 : Colors.white,
              textColor: AppColors.textColorHigh,
            ),
          ],
        ),
        const SizedBox(
          height: 21,
        ),
        SizedBox(
          height: 354,
          width: 175,
          child: Stack(
            children: isFront ? manFront : manBack,
          ),
        )
      ],
    );

  }
}

import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/sizes.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:dasgal/presentation/screens/authentication/phone_number.dart';
import 'package:dasgal/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 54, right: 54, top: 64, bottom: 46),
            child: Lottie.asset("assets/lottie/intro.json", width: double.infinity),
          ),
          Text(
            "Дасгал апп",
            style: AppStyle.textHeader5.copyWith(fontWeight: FontWeight.bold, color: AppColors.textColorHigh),
          ),
          const SizedBox(height: 26,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 54),
            child: Text(
              "Та өглөө ердөө 5 минутыг өөртөө зарцуулаарай",
              textAlign: TextAlign.center,
              style: AppStyle.textBody1.copyWith( color: AppColors.textColor),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin, vertical: 16),
                child: CustomButton(
                    action: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PhoneNumberScreen(isLogin: false)),
                      );
                    },
                    color: AppColors.primary,
                    frameColor: AppColors.primary,
                    textColor: Colors.white,
                    text: 'Бүртгүүлэх'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
                child: CustomButton(
                    action: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PhoneNumberScreen(isLogin: true)),
                      );
                    },
                    color: Colors.white,
                    frameColor: AppColors.primary,
                    textColor: AppColors.primary,
                    text: 'Нэвтрэх'),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/term");
                },
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.containerMargin),
                    child: Text("Та нэвтрэх, бүртгүүлэх товч дарснаар үйлчилгээний нөхцөлийг зөвшөөрнө",
                    textAlign: TextAlign.center,
                      style: AppStyle.textBody2.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

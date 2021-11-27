import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/sizes.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:dasgal/cubit/plan/plan_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  Widget _buildButton(
      IconData iconData, String text, Color color, onClick
      ) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      color: color
                  ),
                  child: Icon(iconData, size: 20, color: Colors.white,),
                ),
                const SizedBox(width: 12,),

                Expanded(child: SizedBox(child: Text(text, style: AppStyle.textSubtitle1,)))
              ],
            ),
          ),
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: AppColors.primaryLight3
            ),
            child: const Center(
              child: Icon(FeatherIcons.chevronRight, color: AppColors.primary, size: 18,),
            ),
          )
        ],
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 56,),
              Text(BlocProvider.of<PlanCubit>(context).getName(), style: AppStyle.textHeader5,),
              SizedBox(height: 56,),
              _buildButton(FeatherIcons.facebook, "Бидэнтэй нэгдэх", AppColors.feedbackInfo, () {
                String facebook = "https://www.facebook.com/groups/598618534523693";
                launch(facebook);
              }),
              SizedBox(height: 16,),
              _buildButton(FeatherIcons.fileText, "Үйлчилгээний нөхцөл, нууцлагын бодлого", AppColors.feedbackAmber, () {
                Navigator.pushNamed(context, "/term");
              }),
              SizedBox(height: 16,),
              _buildButton(FeatherIcons.logOut, "Гарах", AppColors.feedbackError, () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).popAndPushNamed("/options");
              }),

            ],
          ),
        ),
      ),
    );
  }
}

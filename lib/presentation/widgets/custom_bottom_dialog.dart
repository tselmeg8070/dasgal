import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class AppBottomSheet extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Widget? child;

  const AppBottomSheet({Key? key, this.title, this.subTitle, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom / 2),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          _header(context),
          SizedBox(
            height: 32,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            child: title != null
                ? Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: AppStyle.textHeader6.copyWith(fontWeight: FontWeight.bold, color: AppColors.disabled2),
            )
                : Container(),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: subTitle != null
                ? Text(
              subTitle ?? "",
              textAlign: TextAlign.center,
              style: AppStyle.textBody2.copyWith(color: AppColors.textColor),
            )
                : Container(),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 16),
            child: child ?? null,
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.5 - 15, vertical: 8),
            height: 3,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.disabled,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}

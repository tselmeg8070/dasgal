import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Utility {

  static showSnackFailedMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          text,
          style: AppStyle.textBody1.copyWith(color: Colors.white, fontFamily: "Lato"),
        ),
        backgroundColor: AppColors.feedbackError,
        action: SnackBarAction(
          textColor: AppColors.textColorHigh,
          label: 'Хаах',
          onPressed: () {},
        ),
      ),
    );
  }

  static String numberWithCommas(String value) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]},';
    return value.replaceAllMapped(reg, mathFunc);
  }
}

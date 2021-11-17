import 'dart:async';

import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String? title;

  final Widget? widgetTitle;

  final Function? leadingPressed;

  final Widget? actionWidget;

  final double? height;

  final bool? hideLeadingBtn;

  final Color? background;

  final double? elevation;

  CustomAppBar({Key? key, this.title, this.leadingPressed, this.actionWidget, this.widgetTitle, this.height, this.hideLeadingBtn, this.background, this.elevation})
      : this.preferredSize = Size.fromHeight(height ?? 50),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: this.widgetTitle == null
          ? Text(this.title ?? '', style: AppStyle.headerTextStyle.copyWith(fontWeight: FontWeight.w800, color: AppColors.textColorHigh))
          : this.widgetTitle,
      centerTitle: true,
      backgroundColor: this.background ?? Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.light, statusBarColor: this.background ?? Colors.transparent),
      elevation: elevation ?? 0,
      automaticallyImplyLeading: true,
      leading: (this.hideLeadingBtn == null || this.hideLeadingBtn == false) ? IconButton(
        splashRadius: 25,
        icon: Icon(FeatherIcons.chevronLeft, color: AppColors.textColorHigh,),
        onPressed: () {
          if (leadingPressed != null) {
            leadingPressed!();
          } else {
            if (MediaQuery.of(context).viewInsets.bottom > 0.0) {
              FocusScope.of(context).unfocus();
              Timer(Duration(milliseconds: 250), () {
                Navigator.maybePop(context);
              });
            } else {
              Navigator.maybePop(context);
            }
          }
        },
      ) : Container(),
      actions: [
        actionWidget ?? Container(),
      ],
    );
  }
}

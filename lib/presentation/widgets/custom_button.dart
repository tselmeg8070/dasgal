import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum CustomButtonSize { small, medium, large, none }

class CustomButton extends StatelessWidget {
  final Function? action;
  final Color? color;
  final Color? textColor;
  final Color? frameColor;
  final bool? leadingIcon;
  final Color? iconColor;
  final IconData? iconData;
  final double? iconSize;
  final String? text;
  final CustomButtonSize size;
  final double elevation;
  final SvgPicture? svgPicture;

  var isLoading;

  CustomButton(
      {this.action,
      this.color,
      this.iconColor,
      this.textColor,
      this.frameColor,
      this.text,
      this.iconData,
      this.iconSize,
      this.leadingIcon,
      this.size = CustomButtonSize.medium,
      this.elevation = 0,
      this.svgPicture,
      this.isLoading});

  Widget build(BuildContext context) {
    return Container(
      height: size == CustomButtonSize.small ? AppSizes.buttonHeightSmall : AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading == true
            ? null
            : action != null
                ? () {
                    action!();
                  }
                : null,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          padding: size == CustomButtonSize.large
              ? EdgeInsets.symmetric(horizontal: 28, vertical: 0)
              : (size == CustomButtonSize.medium
                  ? EdgeInsets.symmetric(horizontal: 24, vertical: 0)
                  : EdgeInsets.symmetric(horizontal: 10, vertical: 0)),
          shadowColor: AppColors.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius),
              side: BorderSide(
                  color: (action != null && (isLoading == false || isLoading == null))
                      ? frameColor ?? AppColors.primary
                      : Colors.transparent,
                  width: 0.5)),
          primary: this.color ?? AppColors.disabled2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (this.leadingIcon == null || this.leadingIcon == true)
                ? ((this.iconData != null || this.svgPicture != null)
                    ? Padding(
                        padding: EdgeInsets.only(right: this.text != null ? 10 : 0),
                        child: this.iconData != null
                            ? Icon(
                                this.iconData,
                                size: iconSize != null
                                    ? iconSize
                                    : size == CustomButtonSize.large
                                        ? 24
                                        : (size == CustomButtonSize.medium ? 20 : 16),
                                color: iconColor ?? AppColors.primary,
                              )
                            : svgPicture,
                      )
                    : Container())
                : Container(),
            this.isLoading == true
                ? Container(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  )
                : this.text != null
                    ? Text(this.text ?? '',
                        style: TextStyle(
                            fontSize: size == CustomButtonSize.large ? 18 : (size == CustomButtonSize.medium ? 16 : 14),
                            fontWeight: FontWeight.w600,
                            color: action != null ? textColor : AppColors.disabled))
                    : Container(),
            (this.leadingIcon == false && (this.iconData != null || this.svgPicture != null))
                ? Padding(
                    padding: EdgeInsets.only(left: this.text != null ? 16 : 0),
                    child: this.iconData != null
                        ? Icon(
                            this.iconData,
                            size: size == CustomButtonSize.large ? 24 : (size == CustomButtonSize.medium ? 20 : 16),
                            color: iconColor ?? AppColors.primary,
                          )
                        : svgPicture,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

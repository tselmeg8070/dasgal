import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/sizes.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomInput extends StatelessWidget {
  final TextEditingController? inputController;
  final String? labelText;
  final String? hintText;
  final String? initValue;
  final String? suffixText;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final int? length;
  final int? maxLength;
  final Color? borderColor;
  final Color? textColor;
  final Function? onChanged;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool? hideText;

  bool? enabled = true;

  CustomInput(
      {Key? key,
      this.inputController,
      this.inputFormatters,
      this.labelText,
      this.hintText,
      this.enabled,
      this.prefixIcon,
      this.length,
      this.maxLength,
      this.suffixIcon,
      this.onChanged,
      this.inputType,
      this.borderColor,
      this.suffixText,
      this.textColor,
      this.initValue,
      this.focusNode,
      this.hideText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: this.borderColor ?? AppColors.primary),
            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          ),
          alignment: Alignment.centerLeft,
          height: 60.0,
          padding: EdgeInsets.only(left: 5),
          child: TextFormField(
            maxLength: maxLength,
            initialValue: this.initValue ?? null,
            controller: this.inputController ?? null,
            keyboardType: inputType == null ? TextInputType.text : inputType,
            inputFormatters: inputFormatters != null ? inputFormatters : [
              LengthLimitingTextInputFormatter(this.length != null ? this.length : 255),
            ],
            obscureText: hideText ?? false,
            enabled: this.enabled,
            style: AppStyle.textBody1.copyWith(fontWeight: FontWeight.bold),
            autofocus: false,
            maxLines: 1,
            focusNode: focusNode ?? null,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: this.prefixIcon != null ? 0 : 20),
              prefixIcon: this.prefixIcon != null ? prefixIcon : null,
              suffixIcon: this.suffixIcon != null ? suffixIcon : null,
              hintText: this.hintText ?? '',
              hintStyle: AppStyle.textHint,
              labelText: this.labelText ?? '',
              suffixText: this.suffixText ?? '',
              suffixStyle: AppStyle.textSubtitle2.copyWith(color: AppColors.textColor, fontWeight: FontWeight.w700),
              labelStyle: AppStyle.labelTextStyle.copyWith(color: this.textColor ?? AppColors.primaryDark1),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
            onTap: () {
              print('tapped');
            },
            onChanged: onChanged != null
                ? (text) {
                    onChanged!(text);
                  }
                : null,
          ),
        ),
      ],
    );
  }
}

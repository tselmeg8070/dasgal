import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/sizes.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:dasgal/core/utilities/utility.dart';
import 'package:dasgal/cubit/authentication/authentication_cubit.dart';
import 'package:dasgal/presentation/screens/authentication/register.dart';
import 'package:dasgal/presentation/widgets/custom_app_bar.dart';
import 'package:dasgal/presentation/widgets/custom_button.dart';
import 'package:dasgal/presentation/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pinput/pin_put/pin_put.dart';

class VerificationScreen extends StatelessWidget {
  final bool isLogin;
  const VerificationScreen({Key? key, required this.isLogin}) : super(key: key);




  Widget _buildPinInput(BuildContext _context, TextEditingController _pinPutController) {
    return Container(
      child: PinPut(
        autofocus: true,
        fieldsCount: 6,
        onSubmit: (String pin) {
          BlocProvider.of<AuthenticationCubit>(_context)
              .verifyOTP(_pinPutController.text);
        },
        // focusNode: _pinPutFocusNode,
        controller: _pinPutController,
        fieldsAlignment: MainAxisAlignment.center,
        eachFieldMargin: EdgeInsets.only(right: 5, left: 5),
        submittedFieldDecoration: _pinPutDecoration,
        eachFieldWidth: 36.0,
        eachFieldHeight: 36.0,
        textStyle: AppStyle.headerLargeTextStyle,
        pinAnimationType: PinAnimationType.scale,
        selectedFieldDecoration: _pinPutDecoration,
        followingFieldDecoration: _pinPutDecoration.copyWith(
          borderRadius: BorderRadius.circular(13.0),
          border: Border.all(
            width: 2,
            color: AppColors.textColor,
          ),
        ),
      ),
    );
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: AppColors.primary, width: 2),
      borderRadius: BorderRadius.circular(13.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _pinPutController = TextEditingController();
    String phone = (BlocProvider.of<AuthenticationCubit>(context).state as SentOTP).phone;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Баталгаажуулах",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 78,),
                Text("Баталгаажуулах код илгээгдлээ",
                  textAlign: TextAlign.center,
                  style: AppStyle.textSubtitle1.copyWith(fontWeight: FontWeight.bold),),
                const SizedBox(height: 12,),
                Text("Таны ${phone} дугаарт илгээгдсэн баталгаажуулах кодыг оруулна уу.",
                  textAlign: TextAlign.center,
                  style: AppStyle.textBody2.copyWith(color: AppColors.textColor),),
                const SizedBox(height: 48,),

                _buildPinInput(context, _pinPutController)
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
                listener: (context, state) {
                  if(state is OTPFailed) {
                    Utility.showSnackFailedMessage(context, state.response);
                  }
                  if(state is OTPVerified) {
                    if(isLogin) {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterScreen()));
                    }
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                      action: (state is OTPLoading) ? null : () {
                        BlocProvider.of<AuthenticationCubit>(context)
                            .verifyOTP(_pinPutController.text);
                      },
                      color: AppColors.primary,
                      frameColor: AppColors.primary,
                      textColor: Colors.white,
                      text: 'Баталгаажуулах');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

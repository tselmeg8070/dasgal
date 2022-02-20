import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/sizes.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:dasgal/core/utilities/utility.dart';
import 'package:dasgal/cubit/authentication/authentication_cubit.dart';
import 'package:dasgal/presentation/screens/authentication/verification.dart';
import 'package:dasgal/presentation/widgets/custom_app_bar.dart';
import 'package:dasgal/presentation/widgets/custom_button.dart';
import 'package:dasgal/presentation/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class PhoneNumberScreen extends StatelessWidget {
  final bool isLogin;
  const PhoneNumberScreen({Key? key, required this.isLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: isLogin ? "Нэвтрэх" : "Бүртгүүлэх",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.containerMargin),
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(height: 78,),
                  Text("Утасны дугаараа оруулна уу",
                    textAlign: TextAlign.center,
                    style: AppStyle.textHeader6.copyWith(
                        fontWeight: FontWeight.bold),),
                  const SizedBox(height: 64,),
                  CustomInput(
                    inputController: phoneController,
                    length: 8,
                    onChanged: (text) {
                      BlocProvider.of<AuthenticationCubit>(context).setPhone(text);
                    },
                    hintText: '99999999',
                    labelText: "Утасны дугаар",
                    inputType: TextInputType.phone,
                    prefixIcon: const Icon(
                      FeatherIcons.phoneCall,
                      color: AppColors.primary,
                    ),
                    // suffixIcon: IconButton(
                    //   onPressed: () {
                    //     phoneController.clear();
                    //   },
                    //   icon: const Icon(Icons.clear_sharp, color: AppColors.primary),
                    // ),
                  ),
                ],
              ),
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 48),
                child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
                  listener: (context, state) {
                    if(state is RegistrationFailed) {
                      Utility.showSnackFailedMessage(context, state.response);
                    }
                    if(state is SentOTP) {
                      Navigator.of(context).push(MaterialPageRoute(builder: (
                          context) => VerificationScreen(isLogin: isLogin)));
                    }
                  },
                  builder: (context, state) {
                    bool validated = BlocProvider.of<AuthenticationCubit>(context).validatePhoneNumber();
                    return CustomButton(
                        action: !validated ? null : () async {
                          if((await BlocProvider.of<AuthenticationCubit>(context).checkPhoneNumber(phoneController.text))) {
                            if(!isLogin) {
                              Utility.showSnackFailedMessage(context, "Уучлаарай, бүртгэлтэй байна.");
                            } else {
                              await BlocProvider.of<AuthenticationCubit>(context).sendOTP();
                            }
                          } else {
                            if(!isLogin) {
                              await BlocProvider.of<AuthenticationCubit>(context).sendOTP();
                            } else {
                              Utility.showSnackFailedMessage(context, "Уучлаарай, бүртгэлгүй байна.");
                            }
                          }
                        },
                        isLoading: state is RegistrationLoading,
                        color: AppColors.primary,
                        frameColor: AppColors.primary,
                        textColor: Colors.white,
                        text: isLogin ? "Нэвтрэх" : "Бүртгүүлэх");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

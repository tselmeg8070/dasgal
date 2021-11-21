import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/sizes.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:dasgal/core/utilities/utility.dart';
import 'package:dasgal/cubit/registration/registration_cubit.dart';
import 'package:dasgal/presentation/widgets/custom_app_bar.dart';
import 'package:dasgal/presentation/widgets/custom_button.dart';
import 'package:dasgal/presentation/widgets/custom_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:pinput/pin_put/pin_put.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final int _stepSize = 5;
  PageController? _pageController;
  var _target = 0.1666666;
  List<String> errorText = [
    'Амаржсан огноо оруулна уу',
    'Таны анхны төрөлт үү?',
    'Хүүхдийн хүйсийг сонгоно уу',
    'Хүүхдийн нэрийг орлууна уу'
  ];
  bool _buttonDisabled = true;
  bool isChecked = false;
  int gender = 0;
  int age = 28;
  int height = 173;
  int weight = 67;
  int weightSub = 0;
  TextEditingController _nameController = new TextEditingController();

  // setting animation on progress bar
  late AnimationController _animationController;
  late Tween<double> _tween;
  late Animation<double> _animation;
  late DateTime pickedDate;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);

    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _tween = Tween(begin: _target, end: _target);

    _animation = _tween.animate(
      CurvedAnimation(
        curve: Curves.easeInOut,
        parent: _animationController,
      ),
    );

    _nameController.text = '';

    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    _animationController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
          appBar: CustomAppBar(
            leadingPressed: () {
              if (_currentIndex > 0) {
                if (_currentIndex == 4) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }
                _pageController!.previousPage(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.linearToEaseOut,
                );
                _setTarget((_target - (1 / _stepSize)).clamp(0, 1));
              } else {
                Navigator.pop(context);
              }
            },
            widgetTitle: Container(margin: EdgeInsets.only(right: 60), child: _buildProgress()),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int index) {
                      if(index == 1 && gender == 0) {
                        setState(() {
                          _buttonDisabled = true;
                        });
                      }
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildNamePage(),
                      _buildGenderPage(),
                      _buildAgePage(),
                      _buildHeightPage(),
                      _buildWeightPage(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom > 0.0 ? 0 : AppSizes.containerMargin),
                  child: Container(
                    margin: const EdgeInsets.all(AppSizes.containerMargin),
                    child: BlocConsumer<RegistrationCubit, RegistrationState>(
                    listener: (context, state) {
                      if(state is RegistrationFailed) {
                        Utility.showSnackFailedMessage(context, "Уучлаарай, алдаа гарлаа");
                      }
                      if(state is RegistrationSuccess) {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        isLoading: state is RegistrationLoading,
                        iconData: FeatherIcons.chevronRight,
                        leadingIcon: false,
                        text: 'Үргэлжлүүлэх',
                        iconColor: _buttonDisabled == true
                            ? AppColors.disabled
                            : Colors.white,
                        action: _isDisabled()
                            ? null
                            : () {
                                if (_currentIndex < (_stepSize - 1)) {
                                  _pageController!.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.linearToEaseOut,
                                  );
                                  _setTarget((_target + (1 / _stepSize)));
                                  FocusScope.of(context).unfocus();
                                } else if (_currentIndex == _stepSize - 1) {
                                  BlocProvider.of<RegistrationCubit>(context).register(_nameController.text,
                                      gender, age, height, weight, weightSub);
                                }
                              },
                        color: AppColors.primary,
                      );
                    },
                  ),
                ),
              ),
                // SizedBox(height: 32,)
              ],
            ),
          ),
        ),
    );

  }

  bool _isDisabled() {
    if(_currentIndex == 0 && _nameController.text.isEmpty) {
      return true;
    }
    if(_currentIndex == 1 && gender == 0) {
      return true;
    }
    return false;
  }


  Widget _buildNamePage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
      child: Column(
        children: [
          Expanded(child: Container()),
          const Text(
            'Таны нэр',
            style: AppStyle.textHeader6,
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: Text(
              '${_nameController.text} үүгээр өөрийгөө өөрчлөх адал явдалаар дүүрэн  аяллаа эхлүүлж байна.',
              textAlign: TextAlign.center,
              style: AppStyle.textBody2.copyWith(color: AppColors.textColor),
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          CustomInput(
            onChanged: (text) {
              setState(() {
                if(text.length > 0) {
                  _buttonDisabled = false;
                }
              });
            },
            inputController: _nameController,
            labelText: 'Нэр',
            hintText: 'Өөрийн нэрээ оруулна уу',
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget _buildGenderPage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
      child: Column(
        children: [
          Expanded(child: Container()),
          const Text(
            'Таны хүйс',
            style: AppStyle.textHeader6,
          ),
          const SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                onTap: () {
                  setState(() {
                    _buttonDisabled = false;
                    gender = 1;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: 218,
                  width: 126,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: gender == 1 ? AppColors.primary : AppColors.textColor, width: 1)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 155,
                        width: 83,
                        child: Image.asset("assets/images/male.png", fit: BoxFit.contain,),
                      ),
                      Text("Эрэгтэй", style: AppStyle.textSubtitle2.copyWith(color: gender == 1 ? AppColors.primary : AppColors.textColor,),),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24,),
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                onTap: () {
                  setState(() {
                    _buttonDisabled = false;
                    gender = 2;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: 218,
                  width: 126,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: gender == 2 ? AppColors.primary : AppColors.textColor, width: 1)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 155,
                        width: 83,
                        child: Image.asset("assets/images/female.png", fit: BoxFit.contain,),
                      ),
                      Text("Эмэгтэй", style: AppStyle.textSubtitle2.copyWith(color: gender == 2 ? AppColors.primary : AppColors.textColor,),),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget _buildAgePage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
      child: Column(
        children: [
          Expanded(child: Container()),
          const Text(
            'Таны нас',
            style: AppStyle.textHeader6,
          ),
          const SizedBox(height: 40,),

          Container(
            height: 250,
            child: CupertinoPicker(
              backgroundColor: Colors.white,
              itemExtent: 42,
              scrollController: FixedExtentScrollController(initialItem: age - 16),
              children: List.generate(80, (index) {
                return Container(
                  height: 42,
                  child: Center(
                    child: Text((16 + index).toString(), textAlign: TextAlign.center, style: AppStyle.textSubtitle1,),
                  ),
                );
              }),
              onSelectedItemChanged: (value) {
                setState(() {
                  age = 16 + value;
                });
              },
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget _buildHeightPage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
      child: Column(
        children: [
          Expanded(child: Container()),
          const Text(
            'Таны өндөр',
            style: AppStyle.textHeader6,
          ),
          const SizedBox(height: 40,),
          Container(
            height: 250,
            child: CupertinoPicker(
              backgroundColor: Colors.white,
              itemExtent: 42,
              scrollController: FixedExtentScrollController(initialItem: height - 100),
              children: List.generate(120, (index) {
                return Container(
                  height: 42,
                  child: Center(
                    child: Text((100 + index).toString() + " см", textAlign: TextAlign.center, style: AppStyle.textSubtitle1,),
                  ),
                );
              }),
              onSelectedItemChanged: (value) {
                setState(() {
                  height = 100 + value;
                });
              },
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget _buildWeightPage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
      child: Column(
        children: [
          Expanded(child: Container()),
          const Text(
            'Таны жин',
            style: AppStyle.textHeader6,
          ),
          const SizedBox(height: 40,),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 250,
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    itemExtent: 42,
                    scrollController: FixedExtentScrollController(initialItem: weight - 30),
                    children: List.generate(120, (index) {
                      return SizedBox(
                        height: 42,
                        child: Center(
                          child: Text((30 + index).toString() + " кг", textAlign: TextAlign.right, style: AppStyle.textSubtitle1,),
                        ),
                      );
                    }),
                    onSelectedItemChanged: (value) {
                      setState(() {
                        weight = 30 + value;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 250,
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    itemExtent: 42,
                    scrollController: FixedExtentScrollController(initialItem: weightSub),
                    children: List.generate(10, (index) {
                      return SizedBox(
                        height: 42,
                        child: Center(
                          child: Text((100 * index).toString().padLeft(3, "0") + " гр", textAlign: TextAlign.left, style: AppStyle.textSubtitle1,),
                        ),
                      );
                    }),
                    onSelectedItemChanged: (value) {
                      setState(() {
                        weightSub = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget _buildProgress() {
    return Row(

        children: List.generate(
            _stepSize,
            (index) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: _currentIndex >= index
                              ? AppColors.primary
                              : AppColors.surfaceSoft),
                    ),
                  ),
                )
        )
    );
  }

  _setTarget(double val) {
    _target = val;
    _tween.begin = _tween.end;
    _animationController.reset();
    _tween.end = val;
    _animationController.forward();
  }




}

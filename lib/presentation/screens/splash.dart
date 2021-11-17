import 'package:dasgal/cubit/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SplashCubit>(context).checkAuthentication();
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        if(state is Authenticated) {
          Navigator.of(context).popAndPushNamed("/main");
        } else if(state is UnAuthenticated) {
          Navigator.of(context).popAndPushNamed("/options");
        } else if(state is Register) {
          Navigator.of(context).popAndPushNamed("/register");
        }
      },
      builder: (context, state) {
        return const Scaffold(
            body: Center(child: Text("Splashing"),)
        );
      },
    );
  }
}

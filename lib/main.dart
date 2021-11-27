import 'package:dasgal/core/themes/app_theme.dart';
import 'package:dasgal/cubit/plan/plan_cubit.dart';
import 'package:dasgal/cubit/registration/registration_cubit.dart';
import 'package:dasgal/cubit/weight/weight_cubit.dart';
import 'package:dasgal/cubit/splash/splash_cubit.dart';
import 'package:dasgal/cubit/authentication/authentication_cubit.dart';
import 'package:dasgal/presentation/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (context) => SplashCubit(),
        ),
        BlocProvider<AuthenticationCubit>(
          create: (context) => AuthenticationCubit(),
        ),
        BlocProvider<RegistrationCubit>(
          create: (context) => RegistrationCubit(),
        ),
        BlocProvider<WeightCubit>(
          create: (context) => WeightCubit(),
        ),
        BlocProvider<PlanCubit>(
          create: (context) => PlanCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Дасгал',
        theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter().onGenerateRoute
      ),
    );
  }
}
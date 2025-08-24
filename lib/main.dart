import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/features/home/data/cubit/home_cubit/home_cubit.dart';
import 'package:quran_app/features/home/presentation/views/home_view.dart';
import 'package:quran_app/features/home/presentation/views/suwar_view.dart';
import 'package:quran_app/features/splash/splash_view.dart';

void main() {
  runApp(QuranApp());
}

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "poppins"),
        initialRoute: '/SplashView',
        routes: {
          '/SplashView': (context) => SplashView(),
          '/HomeView': (context) => HomeView(),
          '/SuwarView': (context) => SuwarView(),
        },
        
      ),
    );
  }
}

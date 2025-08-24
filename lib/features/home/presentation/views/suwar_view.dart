import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_app/features/home/data/cubit/suwar_cubit/suwar_cubit.dart';
import 'package:quran_app/features/home/data/cubit/suwar_cubit/suwar_state.dart';

class SuwarView extends StatelessWidget {
  const SuwarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SuwarCubit, SuwarState>(
        builder: (context, state) {
          if (state is SuccessSuwarState) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return SvgPicture.network(
                  "https://www.m3quran.net/api/quran_pages_svg/002.svg",
                );
              },
            );
          } else if (state is FailureSuwarState) {
            return Center(child: Text(state.message));
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/utils/app_colors.dart';
import 'package:quran_app/features/home/data/cubit/home_cubit/home_cubit.dart';
import 'package:quran_app/features/home/data/cubit/home_cubit/home_state.dart';

class CustomCategoryButton extends StatelessWidget {
  const CustomCategoryButton({super.key, required this.buttonName, this.onTap});
  final String buttonName;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<HomeCubit>(context);
        bool isActive = buttonName == cubit.selectedButtonName;
        return InkWell(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            width: 80,
            height: 40,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondaryColor.withValues(alpha: 0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(-2, 3),
                  blurStyle: BlurStyle.inner,
                ),
              ],
              borderRadius: BorderRadius.circular(25),
              color: isActive ? AppColors.primaryColor : Colors.white,
              border: Border.all(color: AppColors.secondaryColor, width: 1),
            ),
            child: Text(
              buttonName,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}

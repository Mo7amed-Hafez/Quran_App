import 'package:flutter/material.dart';
import 'package:quran_app/core/utils/app_colors.dart';

class LogoName extends StatelessWidget {
  const LogoName({super.key, this.title="My Quran"});
  final String ? title ;

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: TextStyle(
        color: AppColors.primaryColor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/core/utils/app_colors.dart';

class CustomSuwar extends StatelessWidget {
  const CustomSuwar({super.key, required this.title, required this.subtitle});

  final String title;
  final String? subtitle;
  // final int ?surahNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width * 8,
      height: 80,
      decoration: BoxDecoration(
        color: const Color.fromARGB(195, 255, 255, 255),
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.grey,

            spreadRadius: 1,
            offset: const Offset(-2, 4),
          ),
        ],
      ),
      child: ListTile(
        iconColor: AppColors.secondaryColor,
        leading: Icon(Icons.star, size: 30),
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle ?? '',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

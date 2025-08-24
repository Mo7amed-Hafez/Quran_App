import 'package:flutter/material.dart';
import 'package:quran_app/core/utils/app_colors.dart';

class CustomSuwar extends StatelessWidget {
  const CustomSuwar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        height: 100,
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
          leading: const Icon(Icons.star, size: 30),
          title: Text(
            title,
            maxLines: 1,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle ?? '',
            maxLines: 2,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
